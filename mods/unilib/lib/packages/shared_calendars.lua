---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_calendars = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_calendars.open_simple_calendar(clicker)

    -- Called when a player interacts with a simple calendar. e.g. from the .on_right_click()
    --      function of unilib:misc_calendar_simple

    if not clicker:is_player() then
        return itemstack
    end

    local epoch_day = core.get_day_count()
    local year, month, day = unilib.calendars.convert_minetest_epoch(epoch_day)

    local date_string = unilib.calendars.format_date(year, month, day, epoch_day)

    local pname = clicker:get_player_name()
    core.chat_send_player(pname, S("Today is @1.", tostring(date_string)))

end

function unilib.pkg.shared_calendars.open_fancy_calendar(clicker, full_name)

    -- Called when a player interacts with a fancy calendar. e.g. from the .on_right_click()
    --      function of unilib:misc_calendar_fancy

    if not clicker:is_player() then
        return itemstack
    end

    local epoch_day = core.get_day_count()
    local year, month, day = unilib.calendars.convert_minetest_epoch(epoch_day)

    local pname = clicker:get_player_name()
    core.show_formspec(pname, full_name, unilib.calendars.get_month_formspec(pname))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_calendars.init()

    return {
        description = "Shared functions for calendars (original to unilib)",
    }

end
