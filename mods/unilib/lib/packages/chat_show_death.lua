---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_death = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_death.init()

    return {
        description = "Chat command /show_death",
        notes = "Shows full list of player deaths",
        depends = "shared_chat_statistics",
    }

end

function unilib.pkg.chat_show_death.exec()

    core.register_chatcommand("show_death", {
        params = "",
        description = S("Shows full list of player deaths"),

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.stats_bio_flag then
                return false, unilib.pkg.shared_chat_statistics.stats_fail_msg
            end

            local death_list = unilib.pkg.shared_chat_statistics.get_bio_stat(name, "death_list")
            if type(death_list) ~= "table" or #death_list == 0 then
                return false, S("Player @1 has never died!", name)
            end

            unilib.utils.chat_send_player(
                name, S("Player death list for @1 (game and real time)", name)
            )

            for i, mini_table in ipairs(death_list) do

                unilib.utils.chat_send_player(
                    name,
                    " " .. string.format("%-5d", i) .. ": " ..
                    unilib.pkg.shared_chat_statistics.quick_format_game_date(
                        mini_table.date_game, mini_table.epoch
                    )
                )

                unilib.utils.chat_send_player(
                    name,
                    "        " .. unilib.pkg.shared_chat_statistics.quick_format_real_date(
                        mini_table.date_real
                    )
                )

            end

            unilib.utils.chat_send_player(name, S("End of list (deaths found: @1)", #death_list))

        end,
    })

end
