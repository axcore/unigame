---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine.lua
--      Set up chat commands for health, stamina, hydration and advanced cuisine
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local max_level = 20
local cripple_level = 4

---------------------------------------------------------------------------------------------------
-- Chat commands for health, stamina and hydration
-- /reset_health: Resets player health
-- /reset_hunger: Resets player hunger (if player hunger is enabled)
-- /reset_thirst: Resets player thirst (if hydration is enabled)
-- /reset_me: Resets player health, hunger and thirst
-- /cripple_health: Reduces player health
-- /cripple_hunger: Reduces player hunger (if player hunger is enabled)
-- /cripple_thirst: Reduces player thirst (if hydration is enabled)
-- /cripple_me: Reduces player health, hunger and thirst
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("reset_health", {
    params = "",
    description = S("Resets player health"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_hp(max_level)

    end,
})

minetest.register_chatcommand("reset_hunger", {
    params = "",
    description = S("Resets player hunger (if player hunger is enabled)"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not unilib.hunger_enable_flag then
            return false, S("Player hunger is not enabled!")
        else
            unilib.stamina_set_saturation(minetest.get_player_by_name(name), max_level)
        end

    end,
})

minetest.register_chatcommand("reset_thirst", {
    params = "",
    description = S("Resets player thirst (if hydration is enabled)"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not unilib.thirst_enable_flag then
            return false, S("Hydration is not enabled!")
        else
            unilib.hydration_do_drink(minetest.get_player_by_name(name), max_level)
        end

    end,
})

minetest.register_chatcommand("reset_me", {
    params = "",
    description = S("Resets player health, hunger and thirst"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_hp(max_level)

        if unilib.hunger_enable_flag then
            unilib.stamina_set_saturation(player, max_level)
        end

        if unilib.thirst_enable_flag then
            unilib.hydration_do_drink(player, max_level)
        end

    end,
})

minetest.register_chatcommand("cripple_health", {
    params = "",
    description = S("Reduces player health"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_hp(cripple_level)

    end,
})

minetest.register_chatcommand("cripple_hunger", {
    params = "",
    description = S("Reduces player hunger (if player hunger is enabled)"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not unilib.hunger_enable_flag then
            return false, S("Player hunger is not enabled!")
        else
            unilib.stamina_set_saturation(minetest.get_player_by_name(name), cripple_level)
        end

    end,
})

minetest.register_chatcommand("cripple_thirst", {
    params = "",
    description = S("Reduces player thirst (if hydration is enabled)"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not unilib.thirst_enable_flag then
            return false, S("Hydration is not enabled!")
        else
            unilib.hydration_set_hydro(minetest.get_player_by_name(name), cripple_level)
        end

    end,
})

minetest.register_chatcommand("cripple_me", {
    params = "",
    description = S("Reduces player health, hunger and thirst"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_hp(cripple_level)

        if unilib.hunger_enable_flag then
            unilib.stamina_set_saturation(player, cripple_level)
        end

        if unilib.thirst_enable_flag then
            unilib.hydration_set_hydro(player, cripple_level)
        end

    end,
})

---------------------------------------------------------------------------------------------------
-- Chat commands for advanced cuisine
-- /clear_food_history: Clears the player's food history  (if advanced cuisine is enabled)
-- /show_food_history: Shows the player's food history (if advanced cuisine is enabled)
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("clear_food_history", {
    params = "",
    description = S("Clears your food history (if advanced cuisine is enabled)"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not unilib.cuisine_advanced_flag then

            return false, S("Advanced cuisine is not enabled!")

        else

            unilib.cuisine_clear_history(minetest.get_player_by_name(name))
            return true, S("Food history has been cleared")

        end

    end,
})

minetest.register_chatcommand("show_food_history", {
    params = "",
    description = S("Shows your food history (if advanced cuisine is enabled)"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not unilib.cuisine_advanced_flag then

            return false, S("Advanced cuisine is not enabled!")

        else

            local history_list = unilib.cuisine_get_history(minetest.get_player_by_name(name))
            if #history_list == 0 then

                return false, S("Your food history is empty!")

            else

                minetest.chat_send_player(name, S("Food history for player @1", name))
                for _, group in pairs(history_list) do
                    minetest.chat_send_player(name, "   " .. group)
                end

                minetest.chat_send_player(
                    name, S("End of list (food groups found: @1)", #history_list)
                )

            end

        end

    end,
})

