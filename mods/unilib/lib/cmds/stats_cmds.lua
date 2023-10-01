---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stats_cmds.lua
--      Set up chat commands for showing player statistics
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local fail_msg = S("Statistics are not enabled (you can enable them in Minetest settings)")

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function quick_format_game_date(date_game, epoch)

    if date_game == nil then

        return ""

    elseif not string.find(date_game, "^[0-9]") then

        return date_game

    else

        return unilib.format_date(
            tonumber(string.sub(date_game, 1, 4)),
            tonumber(string.sub(date_game, 5, 6)),
            tonumber(string.sub(date_game, 7, 8)),
            epoch
        )

    end

end

local function quick_format_real_date(date_real)

    if date_real == nil then

        return ""

    elseif not string.find(date_real, "^[0-9]") then

        return date_real

    else

        return unilib.format_date(
            tonumber(string.sub(date_real, 1, 4)),
            tonumber(string.sub(date_real, 5, 6)),
            tonumber(string.sub(date_real, 7, 8)),
            nil,
            tonumber(string.sub(date_real, 9, 10)),
            tonumber(string.sub(date_real, 11, 12)),
            tonumber(string.sub(date_real, 13, 14)),
            "%D, %d %M %y %T"
        )

    end

end

local function get_bio_stat(pname, stat_name, nul_value)

    local value = unilib.player_stats_bio_table[pname][stat_name]
    if type(value) ~= "table" and (value == nil or value == "") then

        if nul_value == nil then
            value = "?"
        else
            value = nul_value
        end

    end

    return value

end

local function get_bio_size_stat(pname, stat_name)

    -- Assumes a table with item as keys, and numerical values, 0 or above; e.g.
    --      data_table["unilib:stone_ordinary"] = 10

    local data_table = unilib.player_stats_bio_table[pname][stat_name]
    if type(data_table) ~= "table" then

        return 0, 0

    else

        local key_count = 0
        local value_total = 0
        for _, v in pairs(data_table) do

            key_count = key_count + 1
            value_total = value_total + v

        end

        return key_count, value_total

    end

end

local function get_activity_stat(pname, stat_name, nul_value)

    local value = unilib.player_stats_activity_table[pname][stat_name]
    if type(value) ~= "table" and (value == nil or value == "") then

        if nul_value == nil then
            value = "?"
        else
            value = nul_value
        end

    end

    return value

end

local function get_activity_size_stat(pname, stat_name)

    -- Assumes a table with item as keys, and numerical values, 0 or above; e.g.
    --      data_table["unilib:stone_ordinary"] = 10

    local data_table = unilib.player_stats_activity_table[pname][stat_name]
    if type(data_table) ~= "table" then

        return 0, 0

    else

        local key_count = 0
        local value_total = 0
        for _, v in pairs(data_table) do

            key_count = key_count + 1
            value_total = value_total + v

        end

        return key_count, value_total

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (chat commands)
---------------------------------------------------------------------------------------------------

local function do_show_statistics(name, param)

    if not minetest.get_player_by_name(name) then
        return false, unilib.chat_offline_msg
    elseif not unilib.stats_bio_flag and not unilib.stats_activity_flag then
        return false, fail_msg
    end

    -- If "param" is set to a player name (and it's not the same player name as "name"), then show
    --      a reduced set of statistics (unless the player "name" has admin privileges)
    local show_all_flag = true
    if param ~= nil and param ~= "" and param ~= name then

        if unilib.player_stats_bio_table[param] == nil and
                unilib.player_stats_activity_table[param] == nil then
            return false, S("The player @1 is not connected", param)
        end

        if not minetest.check_player_privs(name, "unilib_admin") then
            show_all_flag = false
        end

    else

        param = name

    end

    if unilib.stats_bio_flag then

        minetest.chat_send_player(name, S("Biographical statistics for player @1", param))

        local birth_epoch = get_bio_stat(param, "birth_epoch")
        if birth_epoch ~= "?" then
            birth_epoch = birth_epoch + 1
        end

        minetest.chat_send_player(name, "   Born (game day):          " .. birth_epoch)

        minetest.chat_send_player(
            name,
            "   Born (game time):         " ..
            quick_format_game_date(get_bio_stat(param, "birth_date_game"))
        )

        minetest.chat_send_player(
            name,
            "   Born (real time):         " ..
            quick_format_real_date(get_bio_stat(param, "birth_date_real"))
        )

        local death_epoch = get_bio_stat(param, "death_epoch")
        if death_epoch ~= "?" then
            death_epoch = death_epoch + 1
        end

        minetest.chat_send_player(name, "   Died (game day):          " .. death_epoch)

        minetest.chat_send_player(
            name,
            "   Died (game time):         " ..
            quick_format_game_date(get_bio_stat(param, "death_date_game"))
        )

        minetest.chat_send_player(
            name,
            "   Died (real time):         "
            .. quick_format_real_date(get_bio_stat(param, "death_date_real"))
        )

        if show_all_flag then

            minetest.chat_send_player(
                name, "   Total deaths:             " .. get_bio_stat(param, "death_count")
            )

        end

        local login_epoch = get_bio_stat(param, "login_epoch")
        if login_epoch ~= "?" then
            login_epoch = login_epoch + 1
        end

        minetest.chat_send_player(name, "   Login (game day):         " .. login_epoch)

        minetest.chat_send_player(
            name,
            "   Login (game time):        " ..
            quick_format_game_date(get_bio_stat(param, "login_date_game"))
        )

        minetest.chat_send_player(
            name,
            "   Login (real time):        " ..
            quick_format_real_date(get_bio_stat(param, "login_date_real"))
        )

        if show_all_flag then

            minetest.chat_send_player(
                name, "   Total logins:             " .. get_bio_stat(param, "login_count")
            )

        end

        minetest.chat_send_player(
            name,
            "   Connected (session):      " ..
            unilib.format_time(get_bio_stat(param, "connected_session"))
        )

        minetest.chat_send_player(
            name,
            "   Connected (total):        " ..
            unilib.format_time(get_bio_stat(param, "connected_total"))
        )

        minetest.chat_send_player(name, S("End of list"))

    end

    if unilib.stats_activity_flag and show_all_flag then

        minetest.chat_send_player(name, S("Activity statistics for player @1", param))

        local key_count, value_total = get_activity_size_stat(param, "dig_table")
        minetest.chat_send_player(name, "   Unique items dug:         " .. key_count)
        minetest.chat_send_player(name, "   Total items dug:          " .. value_total)

        key_count, value_total = get_activity_size_stat(param, "place_table")
        minetest.chat_send_player(name, "   Unique items placed:      " .. key_count)
        minetest.chat_send_player(name, "   Total items placed:       " .. value_total)

        key_count, value_total = get_activity_size_stat(param, "craft_table")
        minetest.chat_send_player(name, "   Unique items crafted:     " .. key_count)
        minetest.chat_send_player(name, "   Total items crafted:      " .. value_total)

        key_count, value_total = get_activity_size_stat(param, "eat_table")
        minetest.chat_send_player(name, "   Unique items eaten/drunk: " .. key_count)
        minetest.chat_send_player(name, "   Total items eaten/drunk:  " .. value_total)

        minetest.chat_send_player(name, S("End of list"))

    end

end

---------------------------------------------------------------------------------------------------
-- /show_statistics: Shows general player stats
--      /show_stats
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("show_statistics", {
    params = "[<player>]",
    description = S("Shows general player statistics"),

    func = function(name, param)
        return do_show_statistics(name, param)
    end,
})

minetest.register_chatcommand("show_stats", {
    params = "[<player>]",
    description = S("Shows general player statistics"),

    func = function(name, param)
        return do_show_statistics(name, param)
    end,
})

---------------------------------------------------------------------------------------------------
-- /show_death: Shows full list of player deaths
-- /show_dig: Shows full list of nodes dug by player
-- /show_place: Shows full list of nodes placed by player
-- /show_craft: Shows full list of items crafted by player
-- /show_eat: Shows full list of items eaten/drunk by player
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("show_death", {
    params = "",
    description = S("Shows full list of player deaths"),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_bio_flag then
            return false, fail_msg
        end

        local death_list = get_bio_stat(name, "death_list")
        if type(death_list) ~= "table" or #death_list == 0 then
            return false, S("Player @1 has never died!", name)
        end

        minetest.chat_send_player(name, S("Player death list for @1 (game and real time)", name))

        for i, mini_table in ipairs(death_list) do

            minetest.chat_send_player(
                name,
                " " .. string.format("%-5d", i) .. ": " ..
                quick_format_game_date(mini_table.date_game, mini_table.epoch)
            )

            minetest.chat_send_player(
                name, "        " .. quick_format_real_date(mini_table.date_real)
            )

        end

        minetest.chat_send_player(name, S("End of list (deaths found: @1)", #death_list))

    end,
})

minetest.register_chatcommand("show_dig", {
    params = "",
    description = S("Shows full list of nodes dug by player"),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_activity_flag then
            return false, fail_msg
        end

        local dig_table = get_activity_stat(name, "dig_table")
        if type(dig_table) ~= "table" or unilib.is_table_empty(dig_table) then
            return false, S("Player @1 has never dug anything!", name)
        end

        minetest.chat_send_player(name, S("Player digging list for @1", name))

        local count = 0
        for _, full_name in ipairs(unilib.sort_table(dig_table)) do

            count = count + 1
            minetest.chat_send_player(
                name, "   " .. string.format("%-5d", dig_table[full_name]) .. " " .. full_name
            )

        end

        minetest.chat_send_player(name, S("End of list (unique items found: @1)", count))

    end,
})

minetest.register_chatcommand("show_place", {
    params = "",
    description = S("Shows full list of nodes placed by player"),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_activity_flag then
            return false, fail_msg
        end

        local place_table = get_activity_stat(name, "place_table")
        if type(place_table) ~= "table" or unilib.is_table_empty(place_table) then
            return false, S("Player @1 has never placed anything!", name)
        end

        minetest.chat_send_player(name, S("Player placing list for @1", name))

        local count = 0
        for _, full_name in ipairs(unilib.sort_table(place_table)) do

            count = count + 1
            minetest.chat_send_player(
                name, "   " .. string.format("%-5d", place_table[full_name]) .. " " .. full_name
            )

        end

        minetest.chat_send_player(name, S("End of list (unique items found: @1)", count))

    end,
})

minetest.register_chatcommand("show_craft", {
    params = "",
    description = S("Shows full list of items crafted by player"),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_activity_flag then
            return false, fail_msg
        end

        local craft_table = get_activity_stat(name, "craft_table")
        if type(craft_table) ~= "table" or unilib.is_table_empty(craft_table) then
            return false, S("Player @1 has never crafted anything!", name)
        end

        minetest.chat_send_player(name, S("Player crafting list for @1", name))

        local count = 0
        for _, full_name in ipairs(unilib.sort_table(craft_table)) do

            count = count + 1
            minetest.chat_send_player(
                name, "   " .. string.format("%-5d", craft_table[full_name]) .. " " .. full_name
            )

        end

        minetest.chat_send_player(name, S("End of list (unique items found: @1)", count))

    end,
})

minetest.register_chatcommand("show_eat", {
    params = "",
    description = S("Shows full list of items eaten/drunk by player"),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_activity_flag then
            return false, fail_msg
        end

        local eat_table = get_activity_stat(name, "eat_table")
        if type(eat_table) ~= "table" or unilib.is_table_empty(eat_table) then
            return false, S("Player @1 has never eaten/drunk anything!", name)
        end

        minetest.chat_send_player(name, S("Player eating/drinking list for @1", name))

        local count = 0
        for _, full_name in ipairs(unilib.sort_table(eat_table)) do

            count = count + 1
            minetest.chat_send_player(
                name, "   " .. string.format("%-5d", eat_table[full_name]) .. " " .. full_name
            )

        end

        minetest.chat_send_player(name, S("End of list (unique items found: @1)", count))

    end,
})

---------------------------------------------------------------------------------------------------
-- /add_event: Adds a calendar event, e.g. "You ate a nice sandwich"
-- /delete_event: Deletes calendar events from the specified game day (e.g. 1 for the first game
--      day, or a string in the form YYYYMMDD)". N.B. Only events of the type "default" can be
--      removed with this command (such as those created with the /add_event command)
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("add_event", {
    params = "[<message>]",
    description = S("Adds a calendar event, e.g. \"You ate a nice sandwich\""),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_bio_flag then
            return false, S("Calendar events cannot be added when player stats are disabled")
        end

        if not unilib.add_player_event(name, "default", param) then
            return false, S("No events added")
        elseif param ~= nil and param ~= "" then
            return true, S("Added event") .. ": " .. param
        else
            return true, S("Added event")
        end

    end,
})

minetest.register_chatcommand("delete_event", {
    params = "<game_day>",
    description = S(
        "Deletes calendar events from the specified game day (e.g. 1 for the first game day, or" ..
                " a string in the form YYYYMMDD). Only events of the \"default\" type can be" ..
                " removed with this command (such as those created with the /add_event command)"
    ),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif not unilib.stats_bio_flag then
            return false, S("Calendar events cannot be modified when player stats are disabled")
        end

        -- N.B. only player events with the "default" event type are removed
        if not unilib.delete_player_event(name, param) then
            return false, S("No events removed")
        else
            return true, S("Removed calendar events from game day @1", param)
        end

    end,
})
