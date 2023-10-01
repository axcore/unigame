---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine.lua
--      Set up advanced cuisine (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Eating foods with the same food group reduces satiation by this factor
local past_factor = 0.1
-- Minimum adjusted satiation, below which the food has no nutritional value
local minimum_satiation = 0.2

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- Original to unilib
-- Advanced cuisine (if enabled) prevents the player from eating the same food over and over again,
--      forcing them to consume a varied diet
-- When a food item is eaten, its food groups (e.g. "food_bread" for "unilib:food_bread_ordinary")
--      are added to a history list, of a maximum size determined by Minetest settings (default 10)
-- Whenever another food item is eaten, its nutritional value is reduced for every instance of the
--      same food group that occurs in the history list
--
-- Packages defining food items should call the function below, like this:
--
--      on_use = unilib.cuisine_eat_on_use("unilib:food_SOMETHING", 5),
--      on_use = unilib.cuisine_eat_on_use("unilib:food_SOMETHING", 5, "unilib:utensil_SOMETHING"),
--
-- ...which replaces lines like these:
--
--      on_use = minetest.item_eat(5),
--      on_use = minetest.item_eat(5, "unilib:utensil_SOMETHING"),
--
-- Packages defining drink items can be used as drinks (if hydration is enabled) or as just another
--      type of food (if not). Those packages should call the function below, like this:
--
--      on_use = unilib.cuisine_drink_on_use("unilib:food_SOMETHING", 2)
--      on_use = unilib.cuisine_drink_on_use("unilib:food_SOMETHING", 2, "unilib:vessel_SOMETHING")
--
-- ...which replaces lines like these:
--
--      on_use = minetest.item_eat(2),
--      on_use = minetest.item_eat(2, "unilib:vessel_SOMETHING"),
--
-- Negative values are used for poisonous foods. There is no need for poisonous foods to call these
--      functions; they can call minetest.item_eat() as normal. If they do call these functions,
--      minetest.item_eat() is used anyway, so the poisonous foods are not added to the player's
--      cuisine history
-- If a satiation value of 0 is used, the player's hunger does not change, and the food is not
--      added to the player's cuisine history (for simplicity)
-- For drinks, the satiation value is ignored if hydration is enabled; all drinks improve the
--      player's thirst by the same amount
-- Note that drinks with a low water content like "unilib:food_milk_coconut" should use a call to
--      unilib.cuisine_eat_on_use(), not unilib.cuisine_drink_on_use()

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.cuisine_eat_on_use(full_name, satiation, replacement_name, old_on_use)

    -- Original to unilib
    -- Returns an .on_use() function for the calling package's craftitem
    -- (Nodes are also acceptable, though not recommended. Tools should not call this function at
    --      all)
    -- The returned function consumes the food, the calls the original .on_use() function (if any)

    return function(itemstack, player, pointed_thing)

        if not unilib.cuisine_advanced_flag or satiation <= 0 then

            -- Revert to original Minetest code
            minetest.item_eat(satiation, replacement_name)
            -- Call original on_use(), if provided
            if old_on_use ~= nil then
                return old_on_use(itemstack, player, pointed_thing)
            else
                return itemstack
            end

        end

        -- Apply the satiation bonus, if the player has never eaten this item before
        local pname = player:get_player_name()
        if unilib.stats_activity_flag and
                unilib.player_stats_activity_table[pname] ~= nil and
                unilib.player_stats_activity_table[pname]["eat_table"] ~= nil and
                unilib.player_stats_activity_table[pname]["eat_table"][full_name] == nil then
            satiation = satiation * unilib.cuisine_novelty_factor
        end

        -- Retrieve the most recent food groups eaten by the player (a list of group names,
        --      separated by whitespace); then convert it to a list
        local history_list = unilib.cuisine_get_history(player)

        -- From the history, compile a table of food groups and their frequencies
        local frequency_table = {}
        for _, group in pairs(history_list) do

            if frequency_table[group] == nil then
                frequency_table[group] = 1
            else
                frequency_table[group] = frequency_table[group] + 1
            end

        end

        -- Retrieve the food groups used by this food
        local def_table = minetest.registered_craftitems[full_name]
        if def_table == nil then
            def_table = minetest.registered_nodes[full_name]
        end

        if def_table == nil then

            unilib.show_warning(
                "unilib.cuisine_eat_on_use(): Non-existent craftitem/node", full_name
            )

            -- Call original on_use(), if provided
            if old_on_use ~= nil then
                return old_on_use(itemstack, player, pointed_thing)
            else
                return itemstack
            end

        elseif def_table.groups == nil then

            -- No food groups assigned, so just revert to original Minetest code
            minetest.item_eat(satiation, replacement_name)
            -- Call original on_use(), if provided
            if old_on_use ~= nil then
                return old_on_use(itemstack, player, pointed_thing)
            else
                return itemstack
            end

        end

        local this_food_group_table = {}
        for group, _ in pairs (def_table.groups) do

            if string.sub(group, 1, 5) == "food_" then
                this_food_group_table[group] = def_table.groups[group]
            end

        end

        -- Compare the two tables, looking for a food group that exists in both
        -- If there are multiple matches, use the most frequent group (e.g. in frequency_table, if
        --      "food_bread" occurs three times but "food_chocolate" occurs only once, then
        --      "food_bread" is the one we use to reduce satiation)
        local match_group = nil
        local match_count = 0
        for k, v in pairs(this_food_group_table) do

            if frequency_table[k] ~= nil and match_count < frequency_table[k] then

                match_group = k
                match_count = frequency_table[k]

            end

        end

        local new_satiation = satiation
        if match_group ~= nil then

            -- Reduce satation by the specified factor
            local factor = 1
            for i = 1, match_count do
                factor = factor + (factor * past_factor)
            end

            new_satiation = new_satiation - (new_satiation * (factor - 1))

            -- Tiny satiation values are treated the same as 0 satiation
            if new_satiation < minimum_satiation then

                minetest.chat_send_player(
                    player:get_player_name(),
                    S("You are sick of @1!", unilib.get_first_line(def_table.description))
                )

                -- Call original on_use(), if provided
                if old_on_use ~= nil then
                    return old_on_use(itemstack, player, pointed_thing)
                else
                    return itemstack
                end

            end

        end

        -- Eat the food. If the new itemstack is identical to the previous one, then nothing was
        --      eaten (and we don't update the food group history)
        local old_count = itemstack:get_count()
        local new_itemstack = minetest.do_item_eat(
            new_satiation, replacement_name, itemstack, player, pointed_thing
        )
        -- (minetest.do_item_eat() returns nil to indicate no inventory change, but we'll still
        --      check the long-winded way)
        if new_itemstack ~= nil and old_count ~= new_itemstack:get_count() then

            -- Update the player's food group history. If a food has two (or more) food groups, add
            --      one of them
            -- (For example, blueberry packages have three food groups; that would mean the player
            --      would get sick of them three times as fast)
            local sorted_table = unilib.sort_table(this_food_group_table)
            table.insert(history_list, sorted_table[1])

            while #history_list > unilib.cuisine_history_max_size do

                -- Food group history full up. remove the oldest items
                table.remove(history_list, 1)

            end

            unilib.set_player_attribute(player, "cuisine_history", table.concat(history_list, " "))

        end

        -- Call original on_use(), if provided
        if old_on_use ~= nil then
            return old_on_use(itemstack, player, pointed_thing)
        else
            return itemstack
        end

    end

end

function unilib.cuisine_drink_on_use(
    full_name, satiation, replacement_name, old_on_use, force_eat_flag
)
    -- Original to unilib
    -- Returns an .on_use() function for the calling package's craftitem. (Nodes are also
    --      acceptable, though not recommended. Tools should not call this function at all)
    -- If hydration is enabled, the returned function increases the player's hydration (to its
    --      maximum level)
    -- Otherwise, the drink is treated as a type of food (as is normal for Minetest drink items),
    --      and unilib.cuisine_eat_on_use() is called to provide a return function instead

    if not unilib.thirst_enable_flag then

        -- Hydration not enabled, so treat this as a food that increases health or stamina
        return unilib.cuisine_eat_on_use(full_name, satiation, replacement_name, old_on_use)

    else

        -- Hydration enabled, so treat this as a drink that increases hydration
        -- Ignore any food groups for the purposes of food group history - if a player wants to
        --      drink nothing but tea, good for them!
        return function(itemstack, player, pointed_thing)

            -- We ignore the satiation value, increasing the player's hydration to its maximum
            -- (25 is the same value used by unilib:utensil_bowl_wooden)
            unilib.hydration_do_drink(player, 25, 25)

            -- If the flag is specified, satiation and hydration are increased at the same time,
            --      (and we still don't update food group history)
            if force_eat_flag then
                minetest.item_eat(satiation)
            end

            -- Call original on_use(), if provided
            if old_on_use ~= nil then
                return old_on_use(itemstack, player, pointed_thing)
            else
                return itemstack
            end

        end

    end

end

function unilib.cuisine_clear_history(player)

    -- Original to unilib (called from the chat command /clear_food_history)
    -- Resets the player attribute

    unilib.set_player_attribute(player, "cuisine_history", "")

end

function unilib.cuisine_get_history(player)

    -- Original to unilib (called from the chat command /clear_food_history, and by the code above)
    -- Obtains the player attribute, converted to a list

    local cuisine_history = unilib.get_player_attribute(player, "cuisine_history") or ""
    return unilib.split_string_by_whitespace(cuisine_history)

end
