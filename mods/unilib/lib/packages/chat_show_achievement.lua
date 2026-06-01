---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_achievement = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show(pname)

    -- Basic checks
    if not unilib.setting.awards_enable_flag then
        return false, S("Player awards are not enabled in settings")
    end

    -- Sort achievements by title (not by name)
    local achievement_list = {}
    for achievement_name, _ in pairs(unilib.global.awards_achievement_table) do
        table.insert(achievement_list, achievement_name)
    end

    table.sort(achievement_list, function(a, b)

        return unilib.global.awards_achievement_table[a].title <
            unilib.global.awards_achievement_table[b].title

    end)

    -- Show the list
    unilib.utils.chat_send_player(pname, S("List of achievement awards"))

    for _, achievement_name in ipairs(achievement_list) do

        local data_table = unilib.global.awards_achievement_table[achievement_name]

        unilib.utils.chat_send_player(
            pname, "   " .. data_table.title .. " [" .. achievement_name .. "]"
        )
        unilib.utils.chat_send_player(pname, "      " .. data_table.description)

    end

    unilib.utils.chat_send_player(pname, S("End of list (achievements found: @1)", #achievement_list))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_achievement.init()

    return {
        description = "Chat commands /show_achievement, /show_achievements",
        notes = "Shows a list of achievement awards",
    }

end

function unilib.pkg.chat_show_achievement.exec()

    core.register_chatcommand("show_achievement", {
        params = "",
        description = S("Shows a list of achievement awards"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

    core.register_chatcommand("show_achievements", {
        params = "",
        description = S("Shows a list of achievement awards"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

end
