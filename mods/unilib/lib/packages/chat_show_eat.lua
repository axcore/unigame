---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_eat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_eat.init()

    return {
        description = "Chat command /show_eat",
        notes = "Shows full list of items eaten/drunk by player",
        depends = "shared_chat_statistics",
    }

end

function unilib.pkg.chat_show_eat.exec()

    core.register_chatcommand("show_eat", {
        params = "",
        description = S("Shows full list of items eaten/drunk by player"),

        func = function(pname, param)

            if not core.get_player_by_name(pname) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.stats_activity_flag then
                return false, unilib.pkg.shared_chat_statistics.stats_fail_msg
            end

            local eat_table = unilib.pkg.shared_chat_statistics.get_activity_stat(
                pname, "eat_table"
            )

            if type(eat_table) ~= "table" or unilib.utils.is_table_empty(eat_table) then
                return false, S("Player @1 has never eaten/drunk anything!", pname)
            end

            unilib.utils.chat_send_player(pname, S("Player eating/drinking list for @1", pname))

            local count = 0
            for _, full_name in ipairs(unilib.utils.sort_table(eat_table)) do

                count = count + 1
                unilib.utils.chat_send_player(
                    pname, "   " .. string.format("%-5d", eat_table[full_name]) .. " " .. full_name
                )

            end

            unilib.utils.chat_send_player(pname, S("End of list (unique items found: @1)", count))

        end,
    })

end
