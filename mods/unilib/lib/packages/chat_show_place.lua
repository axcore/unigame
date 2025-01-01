---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_place = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_place.init()

    return {
        description = "Chat command /show_place",
        notes = "Shows full list of nodes placed by player",
        depends = "shared_chat_statistics",
    }

end

function unilib.pkg.chat_show_place.exec()

    core.register_chatcommand("show_place", {
        params = "",
        description = S("Shows full list of nodes placed by player"),

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.stats_activity_flag then
                return false, unilib.pkg.shared_chat_statistics.stats_fail_msg
            end

            local place_table = unilib.pkg.shared_chat_statistics.get_activity_stat(
                name, "place_table"
            )

            if type(place_table) ~= "table" or unilib.utils.is_table_empty(place_table) then
                return false, S("Player @1 has never placed anything!", name)
            end

            unilib.utils.chat_send_player(name, S("Player placing list for @1", name))

            local count = 0
            for _, full_name in ipairs(unilib.utils.sort_table(place_table)) do

                count = count + 1
                unilib.utils.chat_send_player(
                    name, "   " .. string.format("%-5d", place_table[full_name]) .. " " .. full_name
                )

            end

            unilib.utils.chat_send_player(name, S("End of list (unique items found: @1)", count))

        end,
    })

end
