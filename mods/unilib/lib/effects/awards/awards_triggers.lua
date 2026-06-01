---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards_triggers.lua
--      Sets up trigger prototypes for player awards
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions (event callbacks)
---------------------------------------------------------------------------------------------------

function unilib.awards.on_break(player, full_name, pos)

    if not unilib.utils.is_player(player) or full_name == nil or pos == nil then
        return
    end

    --[[
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_complex_watch_table(player, "unilib_break", full_name)
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        if achievement_table["trigger_table"]["prototype"] == "unilib_break" then
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end
    ]]--
    unilib.awards.handle_complex_trigger(player, "unilib_break", full_name, 1)

end

function unilib.awards.on_chat(player, msg)

    if not unilib.utils.is_player(player) or string.find(msg, "^/") then
        return
    end

    --[[
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, "unilib_chat")
    ) do

        if unilib.awards.apply_filter_as_regex(achievement_name, msg) then
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end
    ]]--
    unilib.awards.handle_simple_filter_as_regex_trigger(player, "unilib_chat", msg, 1)

end

function unilib.awards.on_craft(player, full_name, multiple)

    if not unilib.utils.is_player(player) or full_name == nil or multiple == 0 then
        return
    end

    --[[
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_complex_watch_table(player, "unilib_craft", full_name)
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        if achievement_table["trigger_table"]["prototype"] == "unilib_craft" then
            unilib.awards.increment_achievement_counter(player, achievement_name, multiple)
        end

    end
    ]]--
    unilib.awards.handle_complex_trigger(player, "unilib_craft", full_name, multiple)

end

function unilib.awards.on_die(player, hp_change_table)

    if not unilib.utils.is_player(player) then
        return
    end

    -- N.B. "hp_change_table" is a Minetest PlayerHPChangeReason
    local reason = "unknown"
    if hp_change_table ~= nil and hp_change_table.type ~= nil then
        reason = hp_change_table.type
    end

    --[[
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, "unilib_die")
    ) do

        if unilib.awards.apply_filter(achievement_name, reason) then
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end
    ]]--
    unilib.awards.handle_simple_filter_trigger(player, "unilib_die", reason, 1)

end

function unilib.awards.on_eat(player, full_name, old_size)

    if not unilib.utils.is_player(player) or full_name == nil or old_size == 0 then
        return
    end

    -- N.B. If hunger is enabled (unilib.setting.hunger_enable_flag == true) and the player's
    --      satiation is at maximum, this function is called even though no item was consumed
    -- Filter out those events by allowing the engine to handle eating as normal, before checking
    --      the results
    core.after(0.1, function()

        local new_size = player:get_wielded_item():get_count()
        if new_size < old_size then

            --[[
            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_complex_watch_table(
                    player, "unilib_eat", full_name
                )
            ) do

                local achievement_table = unilib.global.awards_achievement_table[achievement_name]
                if achievement_table["trigger_table"]["prototype"] == "unilib_eat" then
                    unilib.awards.increment_achievement_counter(player, achievement_name, 1)
                end

            end
            ]]--
            unilib.awards.handle_complex_trigger(player, "unilib_eat", full_name, 1)

        end

    end)

end

function unilib.awards.on_join(player)

    if not unilib.utils.is_player(player) then
        return
    end

    --[[
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, "unilib_join")
    ) do
        unilib.awards.increment_achievement_counter(player, achievement_name, 1)
    end
    ]]--
    unilib.awards.handle_simple_trigger(player, "unilib_join", 1)

end

function unilib.awards.on_place(player, full_name, pos)

    if not unilib.utils.is_player(player) or full_name == nil or pos == nil then
        return
    end

    --[[
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_complex_watch_table(player, "unilib_place", full_name)
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        if achievement_table["trigger_table"]["prototype"] == "unilib_place" then
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end
    ]]--
    unilib.awards.handle_complex_trigger(player, "unilib_place", full_name, 1)

end

function unilib.awards.on_receive(pos, oldnode, oldmeta, digger)

    -- To use the trigger prototype "unilib_receive" with any item, override its definition:
    --      core.override(full_name, {
    --          after_dig_node = unilib.awards.on_receive,
    --      })

    local tool = digger and digger:get_wielded_item():get_name()
    local drops = minetest.get_node_drops(oldnode.name, tool)

    for _, item_str in ipairs(drops) do

        local full_name, multiple = unilib.utils.get_item_and_multiple(item_str)

        --[[
        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_complex_watch_table(
                player, "unilib_receive", full_name
            )
        ) do

            local achievement_table = unilib.global.awards_achievement_table[achievement_name]
            if achievement_table["trigger_table"]["prototype"] == "unilib_receive" then
                unilib.awards.increment_achievement_counter(digger, achievement_name, multiple)
            end

        end
        ]]--
        unilib.awards.handle_complex_trigger(digger, "unilib_receive", full_name, multiple)

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Register "standard" trigger prototypes

-- "unilib_break"
unilib.awards.register_trigger_prototype({
    name = "unilib_break",
    trigger_type = "complex",
    hint_list = {"Break one block", "Break @1 blocks"},
    progress_list = {"Break one block", "Break @1/@2 blocks"},
})
core.register_on_dignode(function(pos, oldnode, digger)
    unilib.awards.on_break(digger, oldnode.name, pos)
end)

-- "unilib_chat"
unilib.awards.register_trigger_prototype({
    name = "unilib_chat",
    trigger_type = "simple",
    hint_list = {"Send one chat message", "Send @1 chat messages"},
    progress_list = {"Send one chat message", "Send @1/@2 chat messages"},
})
core.register_on_chat_message(function(name, message)
    unilib.awards.on_chat(core.get_player_by_name(name), message)
end)

-- "unilib_craft"
unilib.awards.register_trigger_prototype({
    name = "unilib_craft",
    trigger_type = "complex",
    hint_list = {"Craft one item", "Craft @1 items"},
    progress_list = {"Craft one item", "Craft @1/@2 items"},
})
core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    unilib.awards.on_craft(player, itemstack:get_name(), itemstack:get_count())
end)

-- "unilib_die"
unilib.awards.register_trigger_prototype({
    name = "unilib_die",
    trigger_type = "simple",
    hint_list = {"Die once", "Die @1 times"},
    progress_list = {"Die once", "Die @1/@2 times"},
})
core.register_on_dieplayer(function(player, hp_change_table)
    unilib.awards.on_die(player, hp_change_table)
end)

-- "unilib_eat"
unilib.awards.register_trigger_prototype({
    name = "unilib_eat",
    trigger_type = "complex",
    hint_list = {"Eat one item", "Eat @1 items"},
    progress_list = {"Eat one item", "Eat @1/@2 items"},
})
core.register_on_item_eat(function(hp_change, replace_with_item, itemstack, user, pointed_thing)
    unilib.awards.on_eat(user, itemstack:get_name(), itemstack:get_count())
end)

-- "unilib_join" (the .register_on_joinplayer() code has been moved to
--      ../lib/effects/awards/awards_base.lua)
unilib.awards.register_trigger_prototype({
    name = "unilib_join",
    trigger_type = "simple",
    hint_list = {"Join the server once", "Join the server @1 times"},
    progress_list = {"Join the server once", "Join the server @1/@2 times"},
})
--[[
core.register_on_joinplayer(function(player, last_login)
    unilib.awards.on_join(player)
end)
]]--

-- "unilib_nothing" (does nothing - use this prototype to add achievements that can't be unlocked,
--      at least not yet, while the author is still writing new awards)
unilib.awards.register_trigger_prototype({
    name = "unilib_nothing",
    trigger_type = "simple",
    hint_list = {"Do nothing", "Do nothing"},
    progress_list = {"Do nothing", "Do nothing"},
})

-- "unilib_place"
unilib.awards.register_trigger_prototype({
    name = "unilib_place",
    trigger_type = "complex",
    hint_list = {"Place one block", "Place @1 blocks"},
    progress_list = {"Place one block", "Place @1/@2 blocks"},
})
core.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    unilib.awards.on_place(placer, newnode.name, pos)
end)

-- "unilib_receive" (an alternative to "unilib_break", in which we count the items actually received
--      from breaking blocks, not the items broken themselves)
unilib.awards.register_trigger_prototype({
    name = "unilib_receive",
    trigger_type = "complex",
    hint_list = {"Obtain one item", "Obtain @1 items"},
    progress_list = {"Obtain one item", "Obtain @1/@2 items"},
})
