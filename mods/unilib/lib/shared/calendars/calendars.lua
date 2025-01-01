---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- calendars.lua
--      Set up calendars
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.calendars = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for calendars
local base_file = unilib.core.path_mod .. "/lib/shared/calendars/calendars_base.lua"

function unilib.calendars.on_receive_fields(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._on_receive_fields(...)

end

function unilib.calendars.customise_weekdays(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._customise_weekdays(...)

end

function unilib.calendars.customise_months(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._customise_months(...)

end

function unilib.calendars.customise_holidays(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._customise_holidays(...)

end

function unilib.calendars.get_day_formspec(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._get_day_formspec(...)

end

function unilib.calendars.get_month_formspec(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._get_month_formspec(...)

end

function unilib.calendars.get_day_of_week(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._get_day_of_week(...)

end

function unilib.calendars.convert_minetest_epoch(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._convert_minetest_epoch(...)

end

function unilib.calendars.deconvert_minetest_epoch(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._deconvert_minetest_epoch(...)

end

function unilib.calendars.format_date(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.calendars._format_date(...)

end
