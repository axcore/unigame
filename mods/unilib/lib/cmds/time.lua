---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- test.lua
--      Set up chat commands for testing arbitrary code
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- See also the "staff_time" package, which provides tools for setting these times

---------------------------------------------------------------------------------------------------
-- Change time of day
-- /day: Changes time to midday
-- /night: Changes time to midnight
-- /dawn: Changes time to dawn
-- /dusk: Changes time to dusk
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("day", {
    params = "",
    description = S("Changes time to midday"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        -- 12:00
        minetest.set_timeofday(0.5)

    end,
})

minetest.register_chatcommand("night", {
    params = "",
    description = S("Changes time to midnight"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        -- 00:00
        minetest.set_timeofday(0)

    end,
})

minetest.register_chatcommand("dawn", {
    params = "",
    description = S("Changes time to dawn"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        -- 4:47
        minetest.set_timeofday(0.2)

    end,
})

minetest.register_chatcommand("dusk", {
    params = "",
    description = S("Changes time to dusk"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        -- 19:12
        minetest.set_timeofday(0.8)

    end,
})

---------------------------------------------------------------------------------------------------
-- Set permanent daylight/nightlight (without changing the game time)
-- /daylight: Enables permanent daylight without changing the game time
-- /darkness: Enables permanent darkness without changing the game time
---------------------------------------------------------------------------------------------------

-- Adapted from the ptime mod

minetest.register_chatcommand("daylight", {
    params = "",
    description = S("Enables permanent daylight without changing the game time"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        if unilib.get_player_attribute(player, "time_mode") == "" or
                unilib.get_player_attribute(player, "time_mode") == "darkness" then

            unilib.set_player_attribute(player, "time_mode", "daylight")
            player:override_day_night_ratio(1)
            return true, S("Permanent daylight has been enabled")

        else

            unilib.set_player_attribute(player, "time_mode", "")
            player:override_day_night_ratio(nil)
            return true, S("Permanent daylight has been disabled")

        end

    end,
})

minetest.register_chatcommand("darkness", {
    params = "",
    description = S("Enables permanent darkness without changing the game time"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        if not unilib.get_player_attribute(player, "time_mode") == "" or
                unilib.get_player_attribute(player, "time_mode") == "daylight" then

            unilib.set_player_attribute(player, "time_mode", "darkness")
            player:override_day_night_ratio(0.1)
            return true, S("Permanent darkness has been enabled")

        else

            unilib.set_player_attribute(player, "time_mode", "")
            player:override_day_night_ratio(nil)
            return true, S("Permanent darkness has been disabled")

        end

    end,
})

minetest.register_on_joinplayer(function(player)

    local pname = player:get_player_name()
    if unilib.get_player_attribute(player, "time_mode") == "daylight" then

        player:override_day_night_ratio(1)
        minetest.chat_send_player(pname, S("Permanent daylight is enabled"))

    elseif unilib.get_player_attribute(player, "time_mode") == "darkness" then

        player:override_day_night_ratio(0.1)
        minetest.chat_send_player(pname, S("Permanent darkness is enabled"))

    end

end)
