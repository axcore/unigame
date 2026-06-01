---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_player_award = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_award(pname, param)

    -- Basic checks
    if not core.get_player_by_name(pname) then

        return false, unilib.constant.chat_offline_msg

    elseif not unilib.setting.awards_enable_flag then

        return false, S("Player awards are not enabled in settings")

    elseif param ~= "" then

        -- If no param specified, then dump award data for the player who typed the command
        pname = param

    elseif unilib.global.awards_player_table[pname] == nil then

        return false, S("No player award data found for \"@1\"", pname)

    end

    local data_table = unilib.global.awards_player_table[pname]

    unilib.utils.chat_send_player(pname, S("Player award data for \"@1\"", pname))

    unilib.utils.chat_send_player(pname, "   Progress in vocations [level number]")
    for _, vocation_name in ipairs(unilib.utils.sort_table(data_table.level_table)) do

        unilib.utils.chat_send_player(
            pname, "      " .. vocation_name .. ": " .. data_table.level_table[vocation_name]
        )

    end

    unilib.utils.chat_send_player(pname, "   Cumulative score in each vocation [score]")
    for _, vocation_name in ipairs(unilib.utils.sort_table(data_table.score_table)) do

        unilib.utils.chat_send_player(
            pname, "      " .. vocation_name .. ": " .. data_table.score_table[vocation_name]
        )

    end

    unilib.utils.chat_send_player(pname, "   Current score in locked achievements [score]")
    for _, achievement_name in ipairs(unilib.utils.sort_table(data_table.current_table)) do

        unilib.utils.chat_send_player(
            pname,
            "      " .. achievement_name .. ": " .. data_table.current_table[achievement_name]
        )

    end

    unilib.utils.chat_send_player(pname, "   Achievements unlocked")
    for _, achievement_name in ipairs(unilib.utils.sort_table(data_table.unlock_table)) do
        unilib.utils.chat_send_player(pname, "      " .. achievement_name)
    end

    unilib.utils.chat_send_player(pname, S("End of list"))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_player_award.init()

    return {
        description = "Chat command /dump_player_award",
        notes = "Dumps player award data",
    }

end

function unilib.pkg.chat_dump_player_award.exec()

    core.register_chatcommand("dump_player_award", {
        params = "[player]",
        description = S(
            "Dumps player award data for the specified player"
        ),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_dump_award(pname, param)
        end,
    })

end
