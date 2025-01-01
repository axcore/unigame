---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_statistics = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show_statistics(pname, param)

    if not core.get_player_by_name(pname) then
        return false, unilib.constant.chat_offline_msg
    elseif not unilib.setting.stats_bio_flag and not unilib.setting.stats_activity_flag then
        return false, unilib.pkg.shared_chat_statistics.stats_fail_msg
    end

    -- If "param" is set to a player name (and it's not the same player name as "pname"), then show
    --      a reduced set of statistics (unless the player "pname" has admin privileges)
    local show_all_flag = true
    if param ~= nil and param ~= "" and param ~= pname then

        if unilib.global.player_stats_bio_table[param] == nil and
                unilib.global.player_stats_activity_table[param] == nil then
            return false, S("The player @1 is not connected", param)
        end

        if not core.check_player_privs(pname, "unilib_admin") then
            show_all_flag = false
        end

    else

        param = pname

    end

    if unilib.setting.stats_bio_flag then

        unilib.utils.chat_send_player(pname, S("Biographical statistics for player @1", param))

        local birth_epoch = unilib.pkg.shared_chat_statistics.get_bio_stat(param, "birth_epoch")
        if birth_epoch ~= "?" then
            birth_epoch = birth_epoch + 1
        end

        unilib.utils.chat_send_player(pname, "   Born (game day):          " .. birth_epoch)

        unilib.utils.chat_send_player(
            pname,
            "   Born (game time):         " ..
            unilib.pkg.shared_chat_statistics.quick_format_game_date(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "birth_date_game")
            )
        )

        unilib.utils.chat_send_player(
            pname,
            "   Born (real time):         " ..
            unilib.pkg.shared_chat_statistics.quick_format_real_date(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "birth_date_real")
            )
        )

        local death_epoch = unilib.pkg.shared_chat_statistics.get_bio_stat(param, "death_epoch")
        if death_epoch ~= "?" then
            death_epoch = death_epoch + 1
        end

        unilib.utils.chat_send_player(pname, "   Died (game day):          " .. death_epoch)

        unilib.utils.chat_send_player(
            pname,
            "   Died (game time):         " ..
            unilib.pkg.shared_chat_statistics.quick_format_game_date(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "death_date_game")
            )
        )

        unilib.utils.chat_send_player(
            pname,
            "   Died (real time):         "
            .. unilib.pkg.shared_chat_statistics.quick_format_real_date(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "death_date_real")
            )
        )

        if show_all_flag then

            unilib.utils.chat_send_player(
                pname,
                "   Total deaths:             " .. unilib.pkg.shared_chat_statistics.get_bio_stat(
                    param, "death_count"
                )
            )

        end

        local login_epoch = unilib.pkg.shared_chat_statistics.get_bio_stat(param, "login_epoch")
        if login_epoch ~= "?" then
            login_epoch = login_epoch + 1
        end

        unilib.utils.chat_send_player(pname, "   Login (game day):         " .. login_epoch)

        unilib.utils.chat_send_player(
            pname,
            "   Login (game time):        " ..
            unilib.pkg.shared_chat_statistics.quick_format_game_date(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "login_date_game")
            )
        )

        unilib.utils.chat_send_player(
            pname,
            "   Login (real time):        " ..
            unilib.pkg.shared_chat_statistics.quick_format_real_date(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "login_date_real")
            )
        )

        if show_all_flag then

            unilib.utils.chat_send_player(
                pname,
                "   Total logins:             " .. unilib.pkg.shared_chat_statistics.get_bio_stat(
                    param, "login_count"
                )
            )

        end

        unilib.utils.chat_send_player(
            pname,
            "   Connected (session):      " ..
            unilib.utils.format_time(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "connected_session")
            )
        )

        unilib.utils.chat_send_player(
            pname,
            "   Connected (total):        " ..
            unilib.utils.format_time(
                unilib.pkg.shared_chat_statistics.get_bio_stat(param, "connected_total")
            )
        )

        unilib.utils.chat_send_player(pname, S("End of list"))

    end

    if unilib.setting.stats_activity_flag and show_all_flag then

        unilib.utils.chat_send_player(pname, S("Activity statistics for player @1", param))

        local key_count, value_total =
                unilib.pkg.shared_chat_statistics.get_activity_size_stat(param, "dig_table")
        unilib.utils.chat_send_player(pname, "   Unique items dug:         " .. key_count)
        unilib.utils.chat_send_player(pname, "   Total items dug:          " .. value_total)

        key_count, value_total =
                unilib.pkg.shared_chat_statistics.get_activity_size_stat(param, "place_table")
        unilib.utils.chat_send_player(pname, "   Unique items placed:      " .. key_count)
        unilib.utils.chat_send_player(pname, "   Total items placed:       " .. value_total)

        key_count, value_total =
                unilib.pkg.shared_chat_statistics.get_activity_size_stat(param, "craft_table")
        unilib.utils.chat_send_player(pname, "   Unique items crafted:     " .. key_count)
        unilib.utils.chat_send_player(pname, "   Total items crafted:      " .. value_total)

        key_count, value_total =
                unilib.pkg.shared_chat_statistics.get_activity_size_stat(param, "eat_table")
        unilib.utils.chat_send_player(pname, "   Unique items eaten/drunk: " .. key_count)
        unilib.utils.chat_send_player(pname, "   Total items eaten/drunk:  " .. value_total)

        unilib.utils.chat_send_player(pname, S("End of list"))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_statistics.init()

    return {
        description = "Chat commands /show_statistics, /show_stats",
        notes = "Shows general player stats",
        depends = "shared_chat_statistics",
    }

end

function unilib.pkg.chat_show_statistics.exec()

    core.register_chatcommand("show_statistics", {
        params = "[player]",
        description = S("Shows general player statistics"),

        func = function(name, param)
            return do_show_statistics(name, param)
        end,
    })

    core.register_chatcommand("show_stats", {
        params = "[player]",
        description = S("Shows general player statistics"),

        func = function(name, param)
            return do_show_statistics(name, param)
        end,
    })

end
