---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_weather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show(pname)

    -- Basic checks
    if not unilib.setting.atmosphere_weather_enable_flag then
        return false, S("Weather effects are currently disabled in settings")
    end

    local weather_list = unilib.atmosphere.get_list_of_weather_effects()
    if #weather_list == 0 then
        return false, S("No weather effects are currently registered")
    end

    -- Show the weather name list
    unilib.utils.chat_send_player(pname, S("List of weather effects"))
    for _, weather_name in ipairs(weather_list) do
        unilib.utils.chat_send_player(pname, "   " .. weather_name)
    end

    unilib.utils.chat_send_player(
        pname, S("End of list (weather effects found: @1)", #weather_list)
    )

    -- Show the weather tag list, if populated
    local tag_list = unilib.atmosphere.get_list_of_weather_tags()
    if #tag_list > 0 then

        unilib.utils.chat_send_player(pname, S("List of weather tags"))
        for _, weather_tag in ipairs(tag_list) do
            unilib.utils.chat_send_player(pname, "   " .. weather_tag)
        end

        unilib.utils.chat_send_player(
            pname, S("End of list (weather tags found: @1)", #tag_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_weather.init()

    return {
        description = "Chat commands /show_weather, /show_weathers",
        notes = "Shows available weather effects",
    }

end

function unilib.pkg.chat_show_weather.exec()

    core.register_chatcommand("show_weather", {
        params = "",
        description = S("Shows available weather effects"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

    core.register_chatcommand("show_weathers", {
        params = "",
        description = S("Shows available weather effects"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

end
