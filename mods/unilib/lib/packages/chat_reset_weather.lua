---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_reset_weather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_reset_weather.init()

    return {
        description = "Chat command /reset_weather",
        notes = "Resets the current weather effect",
    }

end

function unilib.pkg.chat_reset_weather.exec()

    core.register_chatcommand("reset_weather", {
        params = "[player]",
        description = S("Resets the current weather effect"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            if param ~= "" then
                pname = param
            end

            local player = core.get_player_by_name(pname)
            if not player then

                return false, unilib.constant.chat_offline_msg

            elseif not unilib.setting.atmosphere_weather_enable_flag then

                return false, S("Weather effects are currently disabled in settings")

            elseif not unilib.atmosphere.is_weather_in_range(player:get_pos()) then

                return false, S("Weather effects are not available at this elevation")

            else

                local result = unilib.atmosphere.reset_weather(pname)
                if not result then
                    return false, S("Unable to reset weather effect")
                else
                    return true, S("Weather effect reset")
                end

            end

        end,
    })

end
