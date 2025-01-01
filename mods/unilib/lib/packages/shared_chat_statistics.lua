---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_statistics = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_statistics.stats_fail_msg = S(
    "Statistics are not enabled (you can enable them in Minetest settings)"
)

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_statistics.quick_format_game_date(date_game, epoch)

    if date_game == nil then

        return ""

    elseif not string.find(date_game, "^[0-9]") then

        return date_game

    else

        return unilib.calendars.format_date(
            tonumber(string.sub(date_game, 1, 4)),
            tonumber(string.sub(date_game, 5, 6)),
            tonumber(string.sub(date_game, 7, 8)),
            epoch
        )

    end

end

function unilib.pkg.shared_chat_statistics.quick_format_real_date(date_real)

    if date_real == nil then

        return ""

    elseif not string.find(date_real, "^[0-9]") then

        return date_real

    else

        return unilib.calendars.format_date(
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

function unilib.pkg.shared_chat_statistics.get_bio_stat(pname, stat_name, nul_value)

    local value = unilib.global.player_stats_bio_table[pname][stat_name]
    if type(value) ~= "table" and (value == nil or value == "") then

        if nul_value == nil then
            value = "?"
        else
            value = nul_value
        end

    end

    return value

end

function unilib.pkg.shared_chat_statistics.get_bio_size_stat(pname, stat_name)

    -- Assumes a table with item as keys, and numerical values, 0 or above; e.g.
    --      data_table["unilib:stone_ordinary"] = 10

    local data_table = unilib.global.player_stats_bio_table[pname][stat_name]
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

function unilib.pkg.shared_chat_statistics.get_activity_stat(pname, stat_name, nul_value)

    local value = unilib.global.player_stats_activity_table[pname][stat_name]
    if type(value) ~= "table" and (value == nil or value == "") then

        if nul_value == nil then
            value = "?"
        else
            value = nul_value
        end

    end

    return value

end

function unilib.pkg.shared_chat_statistics.get_activity_size_stat(pname, stat_name)

    -- Assumes a table with item as keys, and numerical values, 0 or above; e.g.
    --      data_table["unilib:stone_ordinary"] = 10

    local data_table = unilib.global.player_stats_activity_table[pname][stat_name]
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
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_statistics.init()

    return {
        description = "Shared functions for chat commands for showing player statistics",
    }

end
