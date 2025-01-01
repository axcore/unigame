---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ptime
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_daylight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ptime.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_daylight.init()

    return {
        description = "Chat command /daylight",
        notes = "Enables permanent daylight/darkness without changing the game time. See also" ..
                " the \"staff_time\" package, which provides tools for setting these times",
    }

end

function unilib.pkg.chat_daylight.exec()

    core.register_chatcommand("daylight", {
        params = "",
        description = S("Enables permanent daylight without changing the game time"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            if unilib.utils.get_player_attribute(player, "time_mode") == "" or
                    unilib.utils.get_player_attribute(player, "time_mode") == "darkness" then

                unilib.utils.set_player_attribute(player, "time_mode", "daylight")
                player:override_day_night_ratio(1)
                return true, S("Permanent daylight has been enabled")

            else

                unilib.utils.set_player_attribute(player, "time_mode", "")
                player:override_day_night_ratio(nil)
                return true, S("Permanent daylight has been disabled")

            end

        end,
    })

    core.register_chatcommand("darkness", {
        params = "",
        description = S("Enables permanent darkness without changing the game time"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            if not unilib.utils.get_player_attribute(player, "time_mode") == "" or
                    unilib.utils.get_player_attribute(player, "time_mode") == "daylight" then

                unilib.utils.set_player_attribute(player, "time_mode", "darkness")
                player:override_day_night_ratio(0.1)
                return true, S("Permanent darkness has been enabled")

            else

                unilib.utils.set_player_attribute(player, "time_mode", "")
                player:override_day_night_ratio(nil)
                return true, S("Permanent darkness has been disabled")

            end

        end,
    })

    core.register_on_joinplayer(function(player)

        local pname = player:get_player_name()
        if unilib.utils.get_player_attribute(player, "time_mode") == "daylight" then

            player:override_day_night_ratio(1)
            return true, S("Permanent daylight is enabled")

        elseif unilib.utils.get_player_attribute(player, "time_mode") == "darkness" then

            player:override_day_night_ratio(0.1)
            return true, S("Permanent darkness is enabled")

        end

    end)

end
