---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- calendars_base.lua
--      Base API functions for calendars
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

-- Calendar format. These variables can be updated by any package using the API functions below
local weekday_setup_list = {
    { S("Sunday"), S("Sun") },
    { S("Monday"), S("Mon") },
    { S("Tuesday"), S("Tue") },
    { S("Wednesday"), S("Wed") },
    { S("Thursday"), S("Thu") },
    { S("Friday"), S("Fri") },
    { S("Saturday"), S("Sat") },
}

local month_setup_list = {
    { S("January"), S("Jan"), 31 },
    { S("February"), S("Feb"), 28 },
    { S("March"), S("Mar"), 31 },
    { S("April"), S("Apr"), 30 },
    { S("May"), S("May"), 31 },
    { S("June"), S("Jun"), 30 },
    { S("July"), S("Jul"), 31 },
    { S("August"), S("Aug"), 31 },
    { S("September"), S("Sep"), 30 },
    { S("October"), S("Oct"), 31 },
    { S("November"), S("Nov"), 30 },
    { S("December"), S("Dec"), 31 },
}

local holiday_setup_list = {
    { 1, 1, S("New Year's Day") },
    { 2, 29, S("Leap Day") },
    { 12, 24, S("Christmas Eve") },
    { 12, 25, S("Christmas Day") },
    { 12, 31, S("New Year's Eve") },
}

-- Short lists
local weekday_count = 0
-- (Lists with indexes starting from 0, e.g. 0 = Sunday, 1 = Monday)
local weekday_name_list = {}
local weekday_short_name_list = {}

local month_count = 0
-- (Lists with indexes starting from 0, e.g. 0 = January, 1 = February)
local month_name_list = {}
local month_short_name_list = {}
local month_length_list = {}

-- Table of annual holidays, in the form
--      holiday_table[short_date_code] = list_of_holiday_titles
-- ...where "short_date_code" is a string in the form MMDD, e.g. 0731 (for 31st July)
local holiday_table = {}

-- For standard calendars, 365
local days_in_year = 0
-- For standard calendars, 366, or 365 if unilib.setting.calendar_leap_year_flag is false
local days_in_leap_year = 0

-- For standard calendars, when leap years are enabled, { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 }
--      (following the Tomohiko Sakamoto algorithm)
-- For standard calendars, when leap years are enabled, { 0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5 }
-- If a customised calendar is in use, will contain a different set of values
-- Note that indexes in this list start from 1, e.g. 1 = January, 2 = February
local weekday_offset_list = {}

-- A list of numbers, one for each day in the week (e.g. { 0, 1, 2, 3, 4, 5, 6 }, used to specify
--      which weekday should appear in each column in the month formspec
-- The list is shifted to the left by unilib.setting.calendar_week_start_offset, e.g. for the
--      value 1, it becomes {1, 2, 3, 4, 5, 6, 0} (thus the left-hand column is Monday)
local weekday_column_list = {}

-- Table of players and their most recently-viewed calendar months
-- Table in the form
--      player_table[player_name] = {year = year_number, month = month_number}
local player_table = {}

-- Table of messages displayed as the tooltip, for each day in the month. The table is reset every
--      time the month formspec is opened
-- Table in the form
--      day_msg_table[day_number] = { date_string, tooltip_string }
-- ...where day_number is in the range, for example, 1-31
local day_msg_table = {}

-- Standard grid width/height for fancy calendars (set below)
local calendar_grid_width = 0
local calendar_grid_height = 0

-- Calendar colours
local current_colour = "#ff3a3a"
local selected_colour = "#ffff83"

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function is_leap_year(year)

    -- Returns true if year is a real-life leap year (thus ignoring the value of
    --      unilib.setting.calendar_leap_year_flag), false if not

    if year % 4 == 0 and (not (year % 100 == 0) or year % 400 == 0) then
        return true
    else
        return false
    end

end

local function is_anniversary(pname, year, month, this_day, this_epoch_day)

    local adj_epoch_day = this_epoch_day + 1
    local msg_list = {}

    -- Show 100 day anniversaries, then after that, 1000 day anniversaries

    -- Show anniversaries of the world creation
    if this_epoch_day == 0 then
        table.insert(msg_list, S("The world was created on this day"))
    elseif (adj_epoch_day < 1001 and adj_epoch_day % 100 == 0) or adj_epoch_day % 1000 == 0 then
        table.insert(msg_list, S("World created @1 days ago", adj_epoch_day))
    end

    -- Show anniversaries of the player's birth
    local birth_day = unilib.global.player_stats_bio_table[pname]["birth_epoch"]
    if birth_day ~= nil then

        if birth_day == this_epoch_day then

            table.insert(msg_list, S("You were born on this day"))

        else

            local adj_birth_day = this_epoch_day - birth_day
            if adj_birth_day > 0 and (
                (adj_birth_day < 1001 and adj_birth_day % 100 == 0) or adj_birth_day % 1000 == 0
            ) then
                table.insert(msg_list, S("You were born @1 days ago", adj_birth_day))
            end

        end

    end

    -- Show anniversaries of the player's most recent death
    local death_day = unilib.global.player_stats_bio_table[pname]["death_epoch"]
    if death_day ~= nil then

        if death_day == this_epoch_day then

            table.insert(msg_list, S("You died on this day"))

        else

            local adj_death_day = this_epoch_day - death_day
            if adj_death_day > 0 and (
                (adj_death_day < 1001 and adj_death_day % 100 == 0) or adj_death_day % 1000 == 0
            ) then
                table.insert(msg_list, S("You died @1 days ago", adj_death_day))
            end

        end

    end

    return msg_list

end

local function get_days_in_month(year, month)

    -- Returns the number of days in the customised calendar month, e.g. 31 for the values 2020, 7
    --      (July 2020)

    local leap_flag = is_leap_year(year)
    if unilib.setting.calendar_leap_year_flag and leap_flag and month == 2 then
        return month_length_list[month - 1] + 1
    else
        return month_length_list[month - 1]
    end

end

local function get_prev_month(year, month, day)

    -- Returns the same day in the previous month
    -- If there aren't enough days in the previous month (because it is shorter than the specified
    --      month), or if the "day" argument is -1, returns the last day of the previous month

    month = month - 1
    if month == 0 then

        year = year - 1
        month = month_count

    end

    local days_in_month = get_days_in_month(year, month)
    if day == -1 or day > days_in_month then
        day = days_in_month
    end

    return year, month, day

end

local function get_prev_year(year, month, day)

    -- Returns the same day of the same month, in the previous year
    -- If the same day doesn't exist in the previous year (because it's a leap year), returns the
    --      day before that

    year = year - 1

    local days_in_month = get_days_in_month(year, month)
    if day > days_in_month then
        day = days_in_month
    end

    return year, month, day

end

local function get_next_month(year, month, day)

    -- Returns the same day in the subsequent month
    -- If there aren't enough days in the subsequent month (because it is shorter than the specified
    --      month), or if the "day" argument is -1, returns the last day of the subsequent month

    month = month + 1
    if month > month_count then

        year = year + 1
        month = 1

    end

    local days_in_month = get_days_in_month(year, month)
    if day == -1 or day > days_in_month then
        day = days_in_month
    end

    return year, month, day

end

local function get_next_year(year, month, day)

    -- Returns the same day of the same month, in the subsequent year
    -- If the same day doesn't exist in the subsequent year (because it's a leap year), returns the
    --      day before that

    year = year + 1

    local days_in_month = get_days_in_month(year, month)
    if day > days_in_month then
        day = days_in_month
    end

    return year, month, day

end

local function update_weekday_offset_list()

    -- Called by unilib.calendars.customise_weekdays() and unilib.calendars.customise_months()
    -- Updates the offset table used in calls to unilib.calendars.get_day_of_week()

    weekday_offset_list = {0}
    local offset = 0

    for i = 0, (month_count - 2) do

        offset = offset + (month_length_list[i] % weekday_count)
        if unilib.setting.calendar_leap_year_flag and i == 1 then

            offset = offset - 1
            if offset == 0 then
                offset = 7
            end

        end

        if offset >= weekday_count then
            offset = offset % weekday_count
        end

        table.insert(weekday_offset_list, offset)

    end

end

local function update_calendar_grid_size()

    -- Called by unilib.calendars.customise_weekdays() and unilib.calendars.customise_months()
    -- Updates the size of the grid in fancy calendars

    -- Set width (minimum 6 required for strip of buttons at the bottom)
    if weekday_count > 6 then
        calendar_grid_width = weekday_count
    else
        calendar_grid_width = 6
    end

    -- Set height
    local longest_month = 0
    for _, length in ipairs(month_length_list) do

        if longest_month < length  then
            longest_month = length
        end

    end

    -- Allow one row for every full week, plus two incomplete weeks at the top and bottom
    calendar_grid_height = math.floor(longest_month / weekday_count) + 2

end

---------------------------------------------------------------------------------------------------
-- Callbacks
---------------------------------------------------------------------------------------------------

function unilib.calendars._on_receive_fields(player, formname, fields, full_name)

    if formname ~= full_name or not player:is_player() then
        return
    end

    local pname = player:get_player_name()
    local year, month
    local current_year, current_month, current_day =
            unilib.calendars.convert_minetest_epoch(core.get_day_count())

    if player_table[pname] ~= nil then

        year = player_table[pname]["year"]
        month = player_table[pname]["month"]

    else

        year = current_year
        month = current_month

    end

    for i = 1, month_length_list[month - 1] do

        if fields["day_" .. i] ~= nil then

            core.show_formspec(pname, full_name, unilib.calendars.get_day_formspec(pname, i))
            return

        end

    end

    if fields.prev_year then

        year, month, day = get_prev_year(year, month, 1)

    elseif fields.prev_month then

        year, month, day = get_prev_month(year, month, 1)

    elseif fields.this_month then

        year = current_year
        month = current_month

    elseif fields.next_month then

        year, month, day = get_next_month(year, month, 1)

    elseif fields.next_year then

        year, month, day = get_next_year(year, month, 1)

    elseif fields.day_back then

        year = year
        month = month

    else

        return

    end

    core.show_formspec(
        pname, full_name, unilib.calendars.get_month_formspec(pname, year, month, nil)
    )

end

---------------------------------------------------------------------------------------------------
-- Calendar customisation API
---------------------------------------------------------------------------------------------------

function unilib.calendars._customise_weekdays(data_list)

    -- An API function to customise the behaviour of calendar weekdays
    --
    -- Args:
    --      data_list (list): A list of lists, one for each day of the week, in the form
    --          {long_name, short_name}. Maximum number of weekdays is 99; all additional weekdays
    --          are ignored

    local count = -1
    weekday_name_list = {}
    weekday_short_name_list = {}

    for _, mini_list in ipairs(data_list) do

        count = count + 1

        weekday_name_list[count] = mini_list[1]
        weekday_short_name_list[count] = mini_list[2]

        if count >= 98 then
            break
        end

    end

    weekday_count = count + 1

    if unilib.setting.calendar_week_start_offset > (weekday_count - 1) then
        unilib.setting.calendar_week_start_offset = weekday_count - 1
    end

    weekday_column_list = {}
    local this_column = unilib.setting.calendar_week_start_offset
    for i = 1, weekday_count do

        table.insert(weekday_column_list, this_column)
        this_column = this_column + 1
        if this_column > (weekday_count - 1) then
            this_column = 0
        end

    end

    update_weekday_offset_list()
    update_calendar_grid_size()

end

function unilib.calendars._customise_months(data_list)

    -- An API function to customise the behaviour of calendar months
    --
    -- Args:
    --      data_list (list): A list of lists, one for each month, in the form
    --          {long_name, short_name, number_of_days}. Maximum number of months is 99; all
    --          additional months are ignored. Maximum number_of_days is 99; all higher values are
    --          replaced by 99

    month_name_list = {}
    month_short_name_list = {}
    month_length_list = {}

    days_in_year = 0

    local count = -1
    for _, mini_list in ipairs(data_list) do

        count = count + 1

        days_in_year = days_in_year + mini_list[3]

        month_name_list[count] = mini_list[1]
        month_short_name_list[count] = mini_list[2]

        if mini_list[3] < 1 then
            month_length_list[count] = 1
        elseif mini_list[3] > 99 then
            month_length_list[count] = 99
        else
            month_length_list[count] = mini_list[3]
        end

        if count >= 98 then
            break
        end

    end

    month_count = count + 1

    if unilib.setting.calendar_leap_year_flag then
        days_in_leap_year = days_in_year + 1
    else
        days_in_leap_year = days_in_year
    end

    update_weekday_offset_list()
    update_calendar_grid_size()

end

function unilib.calendars._customise_holidays(data_list)

    -- An API function to customise the table of annual holidays
    --
    -- Args:
    --      data_list (list): A list of lists, each in the form {month, day, holiday_title)

    holiday_table = {}
    for _, mini_list in pairs(data_list) do

        local short_date_code = string.format("%02d%02d", mini_list[1], mini_list[2])

        if holiday_table[short_date_code] == nil then
            holiday_table[short_date_code] = { mini_list[3] }
        else
            table.insert(holiday_table[short_date_code], mini_list[3])
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Calendar general functions
---------------------------------------------------------------------------------------------------

function unilib.calendars._get_day_formspec(pname, day)

    -- Shows a single day of the month

    local mini_list = day_msg_table[day]
    if mini_list == nil then
        return
    end

    local date_msg = mini_list[1]
    local tooltip_msg = mini_list[2]

    -- Insert empty lines between different parts of the tooltip text (not required in the actual
    --      tooltip, but looks better in the textarea)
    tooltip_msg = string.gsub(tooltip_msg, "\n", "\n\n")

    local formspec = "size[6,5]" ..
            "textarea[0.25,0;6,1;;;" .. F(date_msg) .. "]" ..
            "textarea[0.25,1;6,3.75;;;" .. F(tooltip_msg) .. "]" ..
            "button[4.5,4.3;1.5,1;day_back;" .. FS("Back") .. "]tooltip[day_back;" ..
                    FS("Go back to the calendar") .. "]"

    return formspec

end

function unilib.calendars._get_month_formspec(pname, year, month, day)

    -- Shows a single month in the calendar
    -- To highlight a particular day, specify the arguments year, month and day, e.g. 2020, 7, 31
    --      (31 July 2020)
    -- To show a particular month without highlighting a day, specify year and month, but not day
    -- To show the current month, don't specify year

    local current_epoch_day = core.get_day_count()
    local current_year, current_month, current_day =
            unilib.calendars.convert_minetest_epoch(current_epoch_day)

    if year == nil then

        year = current_year
        month = current_month
        day = current_day

    end

    -- Store the formatted date strings, and tooltip text for every day, so it can be displayed in
    --      the day formspec, if required
    day_msg_table = {}

    local formspec = "size[" .. calendar_grid_width .. "," .. (calendar_grid_height + 1.75) .. "]"

    -- Month, year
    formspec = formspec .. "label[0,0;" .. F(month_name_list[month - 1]) .. " " .. year .. "]"

    -- Sanity check - for months that occured before the world start, don't show any calendar
    --      days or buttons (but show all days in the same month as the world start)
    if year < unilib.setting.calendar_year_offset or (
        year == unilib.setting.calendar_year_offset and
        month < unilib.setting.calendar_month_offset
    ) then
        return formspec
    end

    -- Strip of short day names at the top
    local grid_gap = calendar_grid_width - weekday_count
    if grid_gap > 0 then
        grid_gap = grid_gap / 2
    end

    for i = 0, (weekday_count - 1) do

        local column = weekday_column_list[i + 1]

        formspec = formspec .. "label[" .. (i + 0.1 + grid_gap) .. ",0.5;" ..
                F(weekday_short_name_list[column]) .. "]"

    end

    -- Calculate the epoch day of the first day, then we can just increment the value
    local init_epoch_day = unilib.calendars.deconvert_minetest_epoch(year, month, 1)
    local this_epoch_day = init_epoch_day

    -- Grid of boxes, one for each day in this month. The day of the week occupying the left-hand
    --      column is specified by unilib.setting.calendar_week_start_offset
    local x = unilib.calendars.get_day_of_week(year, month, 1) -
            unilib.setting.calendar_week_start_offset

    if x < 0 then
        x = weekday_count + x
    end

    local y = 0

    for this_day = 1, get_days_in_month(year, month) do

        local date_msg, tooltip_msg, short_date_code, long_date_code, img, today_flag
        local anniversary_msg_list = {}

        if unilib.setting.calendar_enable_tooltips_flag then

            date_msg = unilib.calendars.format_date(
                year,
                month,
                this_day,
                unilib.calendars.deconvert_minetest_epoch(year, month, this_day)
            )

            tooltip_msg = ""

        end

        anniversary_msg_list = is_anniversary(pname, year, month, this_day, this_epoch_day)

        if year == current_year and month == current_month and this_day == current_day then

            today_flag = true
            if unilib.setting.calendar_enable_tooltips_flag then
                tooltip_msg = tooltip_msg .. "\n" .. S("Today")
            end

        end

        short_date_code = string.format("%02d%02d", month, this_day)
        long_date_code = string.format("%04d", year) .. short_date_code

        if this_epoch_day < 0 then

            img = "unilib_misc_calendar_bg_ancient.png"

        elseif #anniversary_msg_list > 0 then

            -- When holidays and anniversaries fall on the same day, show messages for both, but
            --      use the anniversary background colour
            if holiday_table[short_date_code] ~= nil then

                img = "unilib_misc_calendar_bg_combined.png"

                if unilib.setting.calendar_enable_tooltips_flag then

                    for _, holiday_title in pairs(holiday_table[short_date_code]) do
                        tooltip_msg = tooltip_msg .. "\n" .. holiday_title
                    end

                end

            else

                img = "unilib_misc_calendar_bg_anniversary.png"

            end

            if unilib.setting.calendar_enable_tooltips_flag then

                for _, anniversary_msg in ipairs(anniversary_msg_list) do
                    tooltip_msg = tooltip_msg .. "\n" .. anniversary_msg
                end

            end

        elseif holiday_table[short_date_code] ~= nil then

            img = "unilib_misc_calendar_bg_holiday.png"

            if unilib.setting.calendar_enable_tooltips_flag then

                for _, holiday_title in pairs(holiday_table[short_date_code]) do
                    tooltip_msg = tooltip_msg .. "\n" .. holiday_title
                end

            end

        elseif this_epoch_day > current_epoch_day then

            img = "unilib_misc_calendar_bg_future.png"

        else

            img = "unilib_misc_calendar_bg_default.png"

        end

        -- (Events are rendered as an overlay texture, not as a specific background texture)
        if unilib.global.player_stats_bio_table[pname]["event_table"] ~= nil then

            local event_list =
                    unilib.global.player_stats_bio_table[pname]["event_table"][long_date_code]
            if event_list ~= nil then

                local death_flag, default_flag, other_flag
                -- mini_list in the form { event_type, event_msg }
                for _, mini_list in pairs(event_list) do

                    if mini_list[1] == "death" then
                        death_flag = true
                    elseif mini_list[1] == "default" then
                        default_flag = true
                    else
                        other_flag = true
                    end

                    if unilib.setting.calendar_enable_tooltips_flag then

                        -- N.B. (v0.18.056) The translated "Event" string causes Minetest errors, so
                        --      it has been omitted omitted
                        --[[
                        tooltip_msg = tooltip_msg .. "\n" .. S("Event") .. " [" .. mini_list[1] ..
                                "]: " .. mini_list[2]
                        ]]--
                        tooltip_msg = tooltip_msg .. "\nEvent [" .. mini_list[1] .. "]: " ..
                                mini_list[2]

                    end

                end

                if death_flag then
                    img = img .. "^unilib_misc_calendar_event_death_overlay.png"
                end

                if default_flag then
                    img = img .. "^unilib_misc_calendar_event_default_overlay.png"
                end

                if other_flag then
                    img = img .. "^unilib_misc_calendar_event_other_overlay.png"
                end
            end

        end

        -- This day's box. We use an image_button, rather than a simple box/image, so that clicking
        --      the button can open the day formspec
        formspec = formspec .. "image_button[" .. (x + grid_gap) .. "," .. (y + 1) .. ";1.1,1;" ..
                img .. ";day_" .. this_day .. ";]label[" .. (x + grid_gap + 0.1) .. "," ..
                (y + 1) .. ";" .. F(this_day) .. "]"

        -- Highlight the current or specified day, if visible
        if year == current_year and month == current_month and this_day == current_day then

            formspec = formspec .. "box[" .. (x - 0.05 + grid_gap) .. "," .. (y + 0.95) ..
                    ";1.01,0.975;" .. current_colour .. "]"

        elseif day == this_day then

            formspec = formspec .. "box[" .. (x - 0.05 + grid_gap) .. "," .. (y + 0.95) ..
                    ";1.01,0.975;" .. selected_colour .. "]"

        end

        -- Show tooltips, if permitted. If not permitted, the same text is visible in the other
        --      formspec
        if unilib.setting.calendar_enable_tooltips_flag then

            -- N.B. The call to unilib.utils.contract_long_lines() removes the initial newline
            --      character at the start of "tooltip_msg", so we must include a new one
            local combi_msg = F(date_msg)
            if tooltip_msg ~= "" then

                -- /grantme_all can easily produce dozens of lines, so limit the size of the tooltip
                -- N.B. The call to unilib.utils.contract_long_lines() removes the initial newline
                --      character at the start of "tooltip_msg", so a new one is added below
                combi_msg = combi_msg .. "\n" .. F(
                    unilib.utils.reduce_lines(
                        unilib.utils.contract_long_lines(tooltip_msg, 65),
                        10,
                        true
                    )
                )

            end

            formspec = formspec .. "tooltip[" .. (x + grid_gap) .. "," .. (y + 1) .. ";1,1;" ..
                    F(combi_msg) .. "]"

        end

        x = x + 1
        if x >= weekday_count then

            x = 0
            y = y + 1

        end

        this_epoch_day = this_epoch_day + 1

        -- Store the text for this day, in case the user wants to open the other formspec
        -- Note that we remove the initial newline character of "tooltip_msg"
        day_msg_table[this_day] = { date_msg, string.sub(tooltip_msg, 2)}

    end

    -- Buttons
    local button_gap = (calendar_grid_width - 5.5) / 2

    if (init_epoch_day - days_in_leap_year) > 0 then

        formspec = formspec .. "button[" .. button_gap .. "," .. (calendar_grid_height + 1) ..
                ";1,1;prev_year;<<]" .. "tooltip[prev_year;" .. FS("Previous year") .. "]"

    end

    if init_epoch_day > 0 then

        formspec = formspec .. "button[" .. button_gap + 1 .. "," .. (calendar_grid_height + 1) ..
                ";1,1;prev_month;<]" .. "tooltip[prev_month;" .. FS("Previous month") .. "]"

    end

    formspec = formspec .. "button[" .. button_gap + 2 .. "," .. (calendar_grid_height + 1) ..
            ";1.5,1;this_month;" .. S("Today") .. "]" .. "tooltip[this_month;" .. FS("Today") .. "]"

    formspec = formspec .. "button[" .. button_gap + 3.5 .. "," .. (calendar_grid_height + 1) ..
            ";1,1;next_month;>]" .. "tooltip[next_month;" .. FS("Next month") .. "]"

    formspec = formspec .. "button[" .. button_gap + 4.5 .. "," .. (calendar_grid_height + 1) ..
            ";1,1;next_year;>>]" .. "tooltip[next_year;" .. FS("Next year") .. "]"

    -- Keep track of the visible month, so the buttons work as expected
    player_table[pname] = {year = year, month = month}

    return formspec

end

function unilib.calendars._get_day_of_week(year, month, day)

    if unilib.setting.calendar_leap_year_flag then

        -- Standard Tomohiko Sakamoto algorithm

        if month < 3 then
            year = year - 1
        end

        return (
            year +
            math.floor(year / 4) -
            math.floor(year / 100) +
            math.floor(year / 400) +
            weekday_offset_list[month] +
            day
        ) % weekday_count

    else

        -- Simplified algorithm without leap years
        return (year + weekday_offset_list[month] + day) % weekday_count

    end

end

function unilib.calendars._convert_minetest_epoch(epoch_day)

    -- Converts the number of days since the world was created (a value returned by
    --      core.get_day_count(), with the first day returning 0), into a date in years, months
    --      and days, taking into account unilib's calendar offsets
    --
    -- e.g. for January 1st, 2020
    --      unilib.setting.calendar_year_offset = 2020
    --      unilib.setting.calendar_month_offset = 1
    --      unilib.setting.calendar_day_offset = 1
    --      core.get_day_count() returns 2 (the 3rd day of the world's existence)
    -- ...returns the list (2020, 1, 3)
    --
    -- Args:
    --      epoch_day (int): The Minetest epoch, an integer value >= 0
    --
    -- Return values:
    --      Three integer values in the form: year (1+), month (e.g. 1-12), day (e.g. 1-31)

    local year = unilib.setting.calendar_year_offset
    local month = unilib.setting.calendar_month_offset
    local day = unilib.setting.calendar_day_offset

    -- Start counting from the first day of the month
    epoch_day = epoch_day + day - 1
    day = 1

    -- Deal with months, one at a time
    while epoch_day > 0 do

        local days_this_month = get_days_in_month(year, month)
        local _

        if epoch_day >= days_this_month then

            epoch_day = epoch_day - days_this_month
            year, month, _ = get_next_month(year, month, 1)

        else

            day = day + epoch_day
            epoch_day = 0

        end

    end

    return year, month, day

end

function unilib.calendars._deconvert_minetest_epoch(year, month, day)

    -- Converts a date expressed as a year (1+), month (e.g. 1-12), day (e.g. 1-31) into the
    --      equivalent Minetest epoch
    -- Note that this function could return a negative epoch (which core.get_gametime() never does)

    -- Start counting from the first day of the month
    local epoch_days = (unilib.setting.calendar_day_offset * -1) + 1

    local this_year = unilib.setting.calendar_year_offset
    local this_month = unilib.setting.calendar_month_offset
    local _

    while this_year < year or (this_year == year and this_month ~= month) do

        epoch_days = epoch_days + get_days_in_month(this_year, this_month)
        this_year, this_month, _ = get_next_month(this_year, this_month, 1)

    end

    return epoch_days + day - 1

end

function unilib.calendars._format_date(
    year, month, day, epoch_day, hour, minute, second, format_string
)
    -- Returns a string in the form "Friday 31 July, 2020 [day #1] [12:30]"
    --
    -- The format of the string is defined by a Minetest setting, "unilib_calendar_format_string"
    --      (whose default value is "%D, %d %M %y %S %E %T"). If necessary, the calling code can
    --      specify its own formatted string
    -- When they occur, the following words are replaced by the arguments to this function:
    --
    --      %y  > year
    --      %m  > month
    --      %d  > day
    --      %e  > epoch_day (we add one to the value of the argument, e.g. the first day of the
    --              Minetest epoch is #0, which would be substituted for the value 1)
    --
    --      %M  > the month name, e.g. "January"
    --      %D  > the weekday name, e.g. "Monday"
    --      %S  > the calendar system, e.g. "A.D." (specified by the Minetest setting
    --              "unilib_calendar_system"
    --      %E  > epoch_day expressed as a string, e.g. "[Day 1]"
    --      %T  > the time, e.g. "12:30" (or "12:30:15" if seconds are specified)
    --
    -- Args:
    --      year, month, day (int): Values typically in the range 1+, 1-12, 1-31
    --      epoch_day (int or nil): If specified, the Minetest epoch matching this date
    --      hour, minute, second (int or nil): If both "hour" and "minute" are specified, a time is
    --          added to the string. If all three are specified, they are all added
    --      format_string (str or nil): If not specified, the Minetest setting
    --          "unilib_calendar_format_string" is used
    --
    -- Return values:
    --      The string described above

    local date_string = format_string or unilib.setting.calendar_format_string
    local day_of_week = unilib.calendars.get_day_of_week(year, month, day)

    local adj_epoch_day
    if epoch_day == nil or epoch_day < 0 then
        adj_epoch_day = ""
    else
        adj_epoch_day = epoch_day + 1
    end

    date_string = string.gsub(date_string, "%%d", day)
    date_string = string.gsub(date_string, "%%m", month)
    date_string = string.gsub(date_string, "%%y", year)
    date_string = string.gsub(date_string, "%%e", adj_epoch_day)

    date_string = string.gsub(date_string, "%%D", weekday_name_list[day_of_week])
    date_string = string.gsub(date_string, "%%M", month_name_list[month - 1])
    date_string = string.gsub(date_string, "%%S", unilib.setting.calendar_system)
    if adj_epoch_day ~= "" then
        date_string = string.gsub(date_string, "%%E", "[Day " .. adj_epoch_day .. "]")
    else
        date_string = string.gsub(date_string, "%%E", "")
    end

    if hour ~= nil and minute ~= nil then

        if second ~= nil then

            date_string = string.gsub(
                date_string,
                "%%T",
                "[" .. string.format("%02d:%02d:%02d", hour, minute, second) .. "]"
            )

        else

            date_string = string.gsub(
                date_string,
                "%%T",
                "[" .. string.format("%02d:%02d", hour, minute) .. "]"
            )

        end

    else

        date_string = string.gsub(date_string, "%%T", "")

    end

    -- Reduce multiple whitespace characters to a single one
    date_string = string.gsub(date_string, "%s+", " ")

    return date_string

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

core.register_on_leaveplayer(function(player)

    local pname = player:get_player_name()
    player_table[pname] = nil

end)

unilib.calendars.customise_weekdays(weekday_setup_list)
unilib.calendars.customise_months(month_setup_list)
unilib.calendars.customise_holidays(holiday_setup_list)

-- Minetest settings must be positive integers; correct any invalid values
if unilib.setting.calendar_year_offset < 1 then
    unilib.setting.calendar_year_offset = 1
end

if unilib.setting.calendar_month_offset < 1 or
        unilib.setting.calendar_month_offset > month_count then
    unilib.setting.calendar_month_offset = 1
end

if unilib.setting.calendar_day_offset < 1 or
        get_days_in_month(
            unilib.setting.calendar_year_offset, unilib.setting.calendar_month_offset
        ) < unilib.setting.calendar_day_offset then
    unilib.setting.calendar_day_offset = 1
end
