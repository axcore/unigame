---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine_eat_base.lua
--      Set up advanced cuisine (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Eating foods with the same food group reduces satiation by this factor
local past_factor = 0.1
-- Minimum adjusted satiation, below which the food has no nutritional value
local minimum_satiation = 0.2

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.cuisine.eat_on_use(full_name, satiation, replacement_name, old_on_use)

    -- Original to unilib
    -- Returns an .on_use() function for the calling package's craftitem
    -- (Nodes are also acceptable, though not recommended. Tools should not call this function at
    --      all)
    -- The returned function consumes the food, the calls the original .on_use() function (if any)

    return function(itemstack, player, pointed_thing)

        -- Inform the relevant awards package, if loaded
        if unilib.global.pkg_executed_table["award_gourmand"] ~= nil then

            unilib.pkg.award_gourmand.on_collect_food(
                player, itemstack:get_name(), itemstack:get_count()
            )

        end

        -- For negative values of satiation (i.e. poison), revert to standard code
        if satiation <= 0 then

            local func = core.item_eat(satiation, replacement_name)
            func(itemstack, player, pointed_thing)

            if old_on_use then
                old_on_use(itemstack, player, pointed_thing)
            end

            return itemstack

        end

        -- Apply the satiation bonus, if the player has never eaten this item before
        local pname = player:get_player_name()
        if unilib.setting.stats_activity_flag and
                unilib.global.player_stats_activity_table[pname] ~= nil and
                unilib.global.player_stats_activity_table[pname]["eat_table"] ~= nil and
                unilib.global.player_stats_activity_table[pname]["eat_table"][full_name] == nil then
            satiation = satiation * unilib.setting.cuisine_novelty_factor
        end

        -- Retrieve the most recent food groups eaten by the player (a list of group names,
        --      separated by whitespace); then convert it to a list
        local history_list = unilib.cuisine.get_history(player)

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
        local def_table = core.registered_craftitems[full_name]
        if def_table == nil then
            def_table = core.registered_nodes[full_name]
        end

        if def_table == nil then

            unilib.utils.show_warning(
                "unilib.cuisine.eat_on_use(): Non-existent craftitem/node", full_name
            )

            -- Revert to standard code
            if old_on_use then
                old_on_use(itemstack, player, pointed_thing)
            end

            return itemstack

        elseif def_table.groups == nil then

            -- No food groups assigned, so just revert to standard code
            local func = core.item_eat(satiation, replacement_name)
            func(itemstack, player, pointed_thing)

            if old_on_use then
                old_on_use(itemstack, player, pointed_thing)
            end

            return itemstack

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

            -- Reduce satiation by the specified factor
            local factor = 1
            for i = 1, match_count do
                factor = factor + (factor * past_factor)
            end

            new_satiation = new_satiation - (new_satiation * (factor - 1))

            -- Tiny satiation values are treated the same as 0 satiation (unless starvation
            --      avoidance mode is active)
            if new_satiation < minimum_satiation then

                if unilib.setting.hunger_enable_flag and
                        unilib.setting.cuisine_avoid_starvation_flag and
                        unilib.stamina.get_saturation(player) <= 2 then

                    -- (Increase satiation by the minimum amount to avoid starvation)
                    new_satiation = 1

                    core.chat_send_player(
                        player:get_player_name(),
                        S(
                            "You are sick of @1, but you are starving!",
                            unilib.utils.get_first_line(def_table.description)
                        )
                    )

                else

                    core.chat_send_player(
                        player:get_player_name(),
                        S("You are sick of @1!", unilib.utils.get_first_line(def_table.description))
                    )

                    -- Revert to standard code
                    if old_on_use then
                        old_on_use(itemstack, player, pointed_thing)
                    end

                    return itemstack

                end

            end

        end

        -- Eat the food. If the new itemstack is identical to the previous one, then nothing was
        --      eaten (and we don't update the food group history)
        local old_count = itemstack:get_count()
        local new_itemstack = core.do_item_eat(
            new_satiation, replacement_name, itemstack, player, pointed_thing
        )

        -- (core.do_item_eat() returns nil to indicate no inventory change, but we'll still check
        --      the long-winded way)
        if new_itemstack ~= nil and old_count ~= new_itemstack:get_count() then

            -- Update the player's food group history. If a food has two (or more) food groups, add
            --      one of them
            -- (For example, blueberry packages have three food groups; that would mean the player
            --      would get sick of them three times as fast)
            local sorted_table = unilib.utils.sort_table(this_food_group_table)
            table.insert(history_list, sorted_table[1])

            while #history_list > unilib.setting.cuisine_history_max_size do

                -- Food group history full up. remove the oldest items
                table.remove(history_list, 1)

            end

            unilib.utils.set_player_attribute(
                player, "cuisine_history", table.concat(history_list, " ")
            )

        end

        -- Call original on_use(), if provided
        if old_on_use then
            old_on_use(itemstack, player, pointed_thing)
        end

        return itemstack

    end

end

function unilib.cuisine.clear_history(player)

    -- Original to unilib (called from the chat command /clear_food_history)
    -- Resets the player attribute

    unilib.utils.set_player_attribute(player, "cuisine_history", "")

end

function unilib.cuisine.get_history(player)

    -- Original to unilib (called from the chat command /clear_food_history, and by the code above)
    -- Obtains the player attribute, converted to a list

    local cuisine_history = unilib.utils.get_player_attribute(player, "cuisine_history") or ""
    return unilib.utils.split_string_by_whitespace(cuisine_history)

end
