---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stats_bio_base.lua
--      Set up player biographical statistics (original to unilib)
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

function unilib.stats.increment_bio_stat(pname, stat_name)

    local count = unilib.global.player_stats_bio_table[pname][stat_name]
    if count == nil or count == "" then
        count = 1
    else
        count = count + 1
    end

    unilib.global.player_stats_bio_table[pname][stat_name] = count

end

function unilib.stats.increase_bio_stat(pname, stat_name, value)

    local old_value = unilib.global.player_stats_bio_table[pname][stat_name]
    if old_value == nil or old_value == "" then
        old_value = value
    else
        old_value = old_value + value
    end

    unilib.global.player_stats_bio_table[pname][stat_name] = old_value

end

function unilib.stats.save_bio_stats()

    for pname, data_table in pairs(unilib.global.player_stats_bio_table) do

        local player = core.get_player_by_name(pname)
        unilib.utils.serialise_player_attribute(player, "stats_bio_table", data_table)

    end

end

---------------------------------------------------------------------------------------------------
-- API functions
---------------------------------------------------------------------------------------------------

function unilib.stats.add_player_event(pname, event_type, event_msg, year, month, day)

    -- An API function to add a player event
    -- A list of player events are stored in player attributes, and are visible in calendars
    --
    -- Args:
    --      pname (str): The player name
    --      event_type (str or nil): Any non-empty string, with the strings "default", "death" and
    --          "priv" considered to be "standard" events. "default" is intended by events created
    --          by the user, using the /add_event command. If an empty string or nil, "default" is
    --          used
    --      event_msg (str or nil): Any string, even an empty one. If nil, an empty string is used
    --      year, month, day (int or nil): If specified, the game day on which the event occured
    --          (which can be converted into a Minetest epoch day). If an invalid day is specified
    --          (such as one before the Minetest epoch), or if any (or all) of the values are nil,
    --          the current game day is used
    --
    -- Return values:
    --      true if at least one event is added, false otherwise

    -- Swap invalid values for valid ones
    if event_type == nil or event_type == "" then
        event_type = "default"
    end

    if event_msg == nil then
        event_msg = ""
    end

    if year == nil or
            month == nil or
            day == nil or
            unilib.calendars.deconvert_minetest_epoch(year, month, day) < 0 then

        local epoch_day = core.get_day_count()
        year, month, day = unilib.calendars.convert_minetest_epoch(epoch_day)

    end

    -- We store events as an ordered list of dates, and a table (which contains the actual events
    --      on those dates)
    local long_date_code = string.format("%04d%02d%02d", year, month, day)

    if unilib.global.player_stats_bio_table[pname]["event_list"] == nil then

        unilib.global.player_stats_bio_table[pname]["event_list"] = {}
        unilib.global.player_stats_bio_table[pname]["event_table"] = {}

    end

    if unilib.global.player_stats_bio_table[pname]["event_table"][long_date_code] == nil then

        table.insert(unilib.global.player_stats_bio_table[pname]["event_list"], long_date_code)
        unilib.global.player_stats_bio_table[pname]["event_table"][long_date_code] =
                { {event_type, event_msg} }

    else

        table.insert(
            unilib.global.player_stats_bio_table[pname]["event_table"][long_date_code],
            {event_type, event_msg}
        )

    end

    return true

end

function unilib.stats.delete_player_event(pname, date_string, event_type)

    -- An API function to remove player events
    --
    -- Args:
    --      pname (str): The player name
    --      date_string (str or int): e.g. 1 for the first game day, or a string in the form
    --              YYYYMMDD)
    --      event_type (str or nil): If specified, any events matching the event_type on the
    --          specified day are removed. If not specified, all events on the specified day are
    --          removed
    --
    -- Return values:
    --      true if at least one event is removed, false otherwise

    -- If date_string is not in the form YYYYMMDD, then convert it
    date_string = tonumber(date_string)
    if date_string == nil then
        return false
    end

    if string.len(tostring(date_string)) ~= 8 then

        local year, month, day = unilib.calendars.convert_minetest_epoch(date_string - 1)
        date_string = string.format("%04d%02d%02d", year, month, day)

    end

    if unilib.global.player_stats_bio_table[pname]["event_table"] == nil or
            unilib.global.player_stats_bio_table[pname]["event_table"][date_string] == nil then
        return false
    end

    local new_list = {}
    local deleted_flag = false
    for _, mini_list in pairs(
        unilib.global.player_stats_bio_table[pname]["event_table"][date_string]
    ) do

        if event_type ~= nil and mini_list[1] ~= event_type then
            table.insert(new_list, mini_list)
        else
            deleted_flag = true
        end

    end

    unilib.global.player_stats_bio_table[pname]["event_table"][date_string] = new_list
    return deleted_flag

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
    unilib.global.player_stats_bio_table[pname] =
            unilib.utils.deserialise_player_attribute(player, "stats_bio_table")

    -- (Failsafe, in case core.register_on_newplayer() was never called)
    if unilib.global.player_stats_bio_table[pname] == nil then
        unilib.global.player_stats_bio_table[pname] = {}
    end

    -- Update stats
    unilib.global.player_stats_bio_table[pname]["login_epoch"] = epoch
    unilib.global.player_stats_bio_table[pname]["login_date_game"] = date_game
    unilib.global.player_stats_bio_table[pname]["login_date_real"] = date_real
    unilib.stats.increment_bio_stat(pname, "login_count")

    unilib.global.player_stats_bio_table[pname]["connected_session"] = 0

end)

core.register_on_leaveplayer(function(player, timed_out)

    local pname = player:get_player_name()
    if unilib.global.player_stats_bio_table[pname] ~= nil then

        unilib.utils.serialise_player_attribute(
            player, "stats_bio_table", unilib.global.player_stats_bio_table[pname]
        )
        unilib.global.player_stats_bio_table[pname] = nil

    end

end)

core.register_on_shutdown(function()
    unilib.stats.save_bio_stats()
end)

-- Player biographical statistics
core.register_on_newplayer(function(player)

    local _, pname, epoch, date_game, date_real
    pname = player:get_player_name()
    epoch, _, _, _, date_game, date_real = get_epoch_and_date()

    unilib.global.player_stats_bio_table[pname] = {}
    unilib.global.player_stats_bio_table[pname]["birth_epoch"] = epoch
    unilib.global.player_stats_bio_table[pname]["birth_date_game"] = date_game
    unilib.global.player_stats_bio_table[pname]["birth_date_real"] = date_real

    unilib.global.player_stats_bio_table[pname]["death_count"] = 0
    unilib.global.player_stats_bio_table[pname]["login_count"] = 0

    -- (Must serialise the data now, so that the incoming core.register_on_joinplayer() call can
    --      retrieve it)
    unilib.utils.serialise_player_attribute(
        player, "stats_bio_table", unilib.global.player_stats_bio_table[pname]
    )

end)

core.register_on_dieplayer(function(player, reason)

    local pname = player:get_player_name()
    local epoch, year, month, day, date_game, date_real = get_epoch_and_date()

    unilib.global.player_stats_bio_table[pname]["death_epoch"] = epoch
    unilib.global.player_stats_bio_table[pname]["death_date_game"] = date_game
    unilib.global.player_stats_bio_table[pname]["death_date_real"] = date_real
    unilib.stats.increment_bio_stat(pname, "death_count")

    if unilib.global.player_stats_bio_table[pname]["death_list"] == nil then
        unilib.global.player_stats_bio_table[pname]["death_list"] = {}
    end

    table.insert(
        unilib.global.player_stats_bio_table[pname]["death_list"],
        {
            epoch = epoch,
            date_game = date_game,
            date_real = date_real,
        }
    )

    unilib.stats.add_player_event(pname, "death", S("You died on this day"), year, month, day)

end)

core.register_on_priv_grant(function(pname, granter, priv)

    local _, year, month, day = get_epoch_and_date()

    -- Minetest documentation warns that this callback may be called twice; ignore the second time,
    --      if any
    if core.check_player_privs(pname, priv) then

        local msg
        if granter == nil then
            msg = S("You were granted the privilege @1", priv)
        else
            msg = S("You were granted the privilege @1 by @2", priv, granter)
        end

        unilib.stats.add_player_event(pname, "priv", msg, year, month, day)

    end

end)

core.register_on_priv_revoke(function(pname, revoker, priv)

    local _, year, month, day = get_epoch_and_date()

    -- Minetest documentation warns that this callback may be called twice; ignore the second time,
    --      if any
    if not core.check_player_privs(pname, priv) then

        local msg
        if revoker == nil then
            msg = S("Your @1 privilege was revoked", priv)
        else
            msg = S("Your @1 privilege was revoked by @2", priv, revoker)
        end

        unilib.stats.add_player_event(pname, "priv", msg, year, month, day)

    end

end)
