---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stats_activity_base.lua
--      Set up player activity statistics (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_epoch_and_date()

    local epoch_day = core.get_day_count()
    local year, month, day = unilib.calendars.convert_minetest_epoch(epoch_day)
    local date_game = string.format("%04d%02d%02d", year, month, day)
    local date_real = os.date("%Y%m%d%H%M%S")

    return epoch_day, year, month, day, date_game, date_real

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.stats.increment_activity_stat(pname, stat_name)

    local count = unilib.global.player_stats_activity_table[pname][stat_name]
    if count == nil or count == "" then
        count = 1
    else
        count = count + 1
    end

    unilib.global.player_stats_activity_table[pname][stat_name] = count

end

function unilib.stats.increase_activity_stat(pname, stat_name, value)

    local old_value = unilib.global.player_stats_activity_table[pname][stat_name]
    if old_value == nil or old_value == "" then
        old_value = value
    else
        old_value = old_value + value
    end

    unilib.global.player_stats_activity_table[pname][stat_name] = old_value

end

function unilib.stats.save_activity_stats()

    for pname, data_table in pairs(unilib.global.player_stats_activity_table) do

        local player = core.get_player_by_name(pname)
        unilib.utils.serialise_player_attribute(player, "stats_activity_table", data_table)

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Serialise/deserialise when player joins/player leaves/on shutdown
core.register_on_joinplayer(function(player, last_login)

    local _, pname, epoch, date_game, date_real
    pname = player:get_player_name()
    epoch, _, _, _, date_game, date_real = get_epoch_and_date()

    -- Import stats
    unilib.global.player_stats_activity_table[pname] =
            unilib.utils.deserialise_player_attribute(player, "stats_activity_table")

    -- (Failsafe, in case core.register_on_newplayer() was never called)
    if unilib.global.player_stats_activity_table[pname] == nil then
        unilib.global.player_stats_activity_table[pname] = {}
    end

end)

core.register_on_leaveplayer(function(player, timed_out)

    local pname = player:get_player_name()
    if unilib.global.player_stats_activity_table[pname] ~= nil then

        unilib.utils.serialise_player_attribute(
            player, "stats_activity_table", unilib.global.player_stats_activity_table[pname]
        )
        unilib.global.player_stats_activity_table[pname] = nil

    end

end)

core.register_on_shutdown(function()
    unilib.stats.save_activity_stats()
end)

-- Player activity statistics
core.register_on_dignode(function(pos, node, player)

    if player == nil or not core.is_player(player) then
        return
    end

    local pname = player:get_player_name()
    if unilib.global.player_stats_activity_table[pname]["dig_table"] == nil then
        unilib.global.player_stats_activity_table[pname]["dig_table"] = {}
    end

    local full_name = node.name
    full_name = core.registered_aliases[full_name] or full_name

    local stat = unilib.global.player_stats_activity_table[pname]["dig_table"][full_name]
    if stat == nil then
        unilib.global.player_stats_activity_table[pname]["dig_table"][full_name] = 1
    else
        unilib.global.player_stats_activity_table[pname]["dig_table"][full_name] = stat + 1
    end

end)

core.register_on_placenode(function(pos, node, player)

    if player == nil or not core.is_player(player) then
        return
    end

    local pname = player:get_player_name()
    if unilib.global.player_stats_activity_table[pname]["place_table"] == nil then
        unilib.global.player_stats_activity_table[pname]["place_table"] = {}
    end

    local full_name = node.name
    full_name = core.registered_aliases[full_name] or full_name

    local stat = unilib.global.player_stats_activity_table[pname]["place_table"][full_name]
    if stat == nil then
        unilib.global.player_stats_activity_table[pname]["place_table"][full_name] = 1
    else
        unilib.global.player_stats_activity_table[pname]["place_table"][full_name] = stat + 1
    end

end)

core.register_on_craft(function(itemstack, player)

    if player == nil or not core.is_player(player) then
        return
    end

    local pname = player:get_player_name()
    if unilib.global.player_stats_activity_table[pname]["craft_table"] == nil then
        unilib.global.player_stats_activity_table[pname]["craft_table"] = {}
    end

    local full_name = itemstack:get_name()
    full_name = core.registered_aliases[full_name] or full_name

    local stat = unilib.global.player_stats_activity_table[pname]["craft_table"][full_name]
    if stat == nil then
        unilib.global.player_stats_activity_table[pname]["craft_table"][full_name] = 1
    else
        unilib.global.player_stats_activity_table[pname]["craft_table"][full_name] = stat + 1
    end

end)

core.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player)

    if player == nil or not core.is_player(player) then
        return
    end

    local pname = player:get_player_name()
    if unilib.global.player_stats_activity_table[pname]["eat_table"] == nil then
        unilib.global.player_stats_activity_table[pname]["eat_table"] = {}
    end

    local full_name = itemstack:get_name()
    full_name = core.registered_aliases[full_name] or full_name

    local stat = unilib.global.player_stats_activity_table[pname]["eat_table"][full_name]
    if stat == nil then
        unilib.global.player_stats_activity_table[pname]["eat_table"][full_name] = 1
    else
        unilib.global.player_stats_activity_table[pname]["eat_table"][full_name] = stat + 1
    end

end)
