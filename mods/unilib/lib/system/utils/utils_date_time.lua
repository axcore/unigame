---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_date_time.lua
--      Date/time utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._format_time(seconds)

    seconds = math.floor(seconds)

    local days = math.floor(seconds / (60 * 60 * 24))
    seconds = seconds % (60 * 60 * 24)

    local hours = math.floor(seconds / (60 * 60))
    seconds = seconds % (60 * 60)

    local minutes = math.floor(seconds / 60)
    seconds = seconds % 60

    local format_string = ""
    if days ~= nil and days ~= 0 then

        if days == 1 then
            format_string = S("1 day")
        else
            format_string = S("@1 days", days)
        end

    end

    if hours ~= nil and hours ~= 0 then

        if format_string ~= "" then
            format_string = format_string .. ", "
        end

        if hours == 1 then
            format_string = format_string .. S("1 hour")
        else
            format_string = format_string .. S("@1 hours", hours)
        end

    end

    if minutes ~= nil and minutes ~= 0 then

        if format_string ~= "" then
            format_string = format_string .. ", "
        end

        if minutes == 1 then
            format_string = format_string .. S("1 minute")
        else
            format_string = format_string .. S("@1 minutes", minutes)
        end

    end

    if format_string ~= "" then
        format_string = format_string .. ", "
    end

    if seconds == 1 then
        format_string = format_string .. S("1 second")
    else
        format_string = format_string .. S("@1 seconds", seconds)
    end

    return format_string

end

function unilib.utils._get_clock_time()

    local t = core.get_timeofday()
    local h = math.floor(t * 24) % 24
    local m = math.floor(t * 1440) % 60

    return string.format("%02d", h) .. ":" .. string.format("%02d", m), h, m

end
