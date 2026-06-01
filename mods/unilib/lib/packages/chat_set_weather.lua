---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_set_weather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_set_weather.init()

    return {
        description = "Chat command /set_weather",
        notes = "Sets the current weather effect, by name or by tag.  Note that this command" ..
                " overrides natural weather selection",
    }

end

function unilib.pkg.chat_set_weather.exec()

    core.register_chatcommand("set_weather", {
        params = "<weather name or tag> [player]",
        description = S("Sets the current weather effect, by name or by tag"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            local arg_list = unilib.utils.split_string_by_whitespace(param)
            local weather_name = arg_list[1]
            local other_pname = arg_list[2]
            if other_pname ~= nil then
                pname = other_pname
            end

            local player = core.get_player_by_name(pname)
            if not player then

                return false, unilib.constant.chat_offline_msg

            elseif not unilib.setting.atmosphere_weather_enable_flag then

                return false, S("Weather effects are currently disabled in settings")

            elseif not unilib.atmosphere.is_weather_in_range(player:get_pos()) then

                return false, S("Weather effects are not available at this elevation")

            elseif not unilib.utils.is_value_in_list(
                weather_name, unilib.atmosphere.get_list_of_weather_effects()
            ) and not unilib.utils.is_value_in_list(
                weather_name, unilib.atmosphere.get_list_of_weather_tags()
            ) then

                return false, S("Unrecognised weather effect (try: /show_weather)")

            else

                local result = unilib.atmosphere.set_weather(pname, weather_name)
                if not result then
                    return false, S("Unable to set weather effect")
                else
                    return true, S("Set weather effect \"@1\"", result)
                end

            end

        end,
    })

end
