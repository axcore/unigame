---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards_formspec.lua
--      Main formspec for player awards
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local vcn_formname = "unilib:form_system_awards_vocations"
local ach_formname = "unilib:form_system_awards_achievements"

-- Vocations/achievement formspec constants
local form_width = 12
local form_height = 12
-- N.B. If the height is changed, the award offset must be changed as well (not necessarily by the
--      same amount)
local award_offset = 5
local padding_top = 1.5
local padding_bottom = 0.5
local padding_left = 0.5
local padding_right = 0.5
local bar_height = 2
local bar_padding = 0.05
local bar_icon_offset_x = 0.5
local bar_title_offset_x = 1.6
local bar_title_offset_y = 0.45
local bar_title_offset_y_nogauge = 0.55
local bar_title_offset_y_special = 0.75
local bar_title_size = 24
local bar_descrip_offset_x = 1.6
local bar_descrip_offset_y = 0.95
local bar_descrip_offset_y_nogauge = 1.05
local bar_descrip_size = 16
local bar_img_size = 1
local bar_img_size_nogauge = 1
local bar_img_size_special = 1
local bar_img_size_small = 0.8
local bar_img_size_small_nogauge = 0.8
local bar_img_posn = 0.2
local bar_img_posn_nogauge = 0.25
local bar_img_posn_special = 0.25
local bar_img_posn_small = 0.25
local bar_img_posn_small_nogauge = 0.3
local bar_gauge_offset_x = 0.5
local bar_gauge_offset_y = 1.5
local bar_gauge_height = 0.2
-- Vocation formspec constants
local vcn_colour_list = {
    gold = {"#FFD700", "#D4AF37", "#000000"},       -- Highest level in vocation, rank 1
    silver = {"#E8E8E8", "#E0DDDD", "#000000"},     -- rank 2
    bronze = {"#E4953C", "#A48347", "#000000"},     -- rank 3
    other = {"#6CC6CC", "#E8E8E8", "#000000"},      -- all other ranks, except the bottom one
    bottom = {"#8A9A9A", "#889A97", "#000000"},     -- the bottom rank
    special = {"#FFFFFF", "#808080", "#000000"},    -- "homeless" achievements
}
local vcn_gauge_colour = "#B30000"
local vcn_gauge_bg_colour = "#000000"

-- Achievement formspec constants
local ach_colour_table = {
    unlocked = {"#98FB98", "008000", "#000000"},    -- (green)
    locked = {"#FFFFE0", "#FADA5E", "#000000"},     -- (yellows)
}
local ach_gauge_colour = "#B30000"
local ach_gauge_bg_colour = "#000000"

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function do_substitution(msg, arg1, arg2)

    -- Returns "msg", after substituting @1 for "arg1" (if specified), and @2 for "arg2" (if
    --      specified)
    -- Used in situations in which we would normally use S(), when "msg" has already been translated

    if arg1 ~= nil then
        msg = msg:gsub("@1", arg1)
    end

    if arg2 ~= nil then
        msg = msg:gsub("@2", arg2)
    end

    return msg

end

---------------------------------------------------------------------------------------------------
-- Local functions (achievements formspec)
---------------------------------------------------------------------------------------------------

local function get_sorted_achievement_list(pname, achievement_list, mode)

    -- Sort achievements, first by the player's progress in that achievement, then by difficulty,
    --      then alphabetically by title
    -- "mode", if specified, can be "locked" to show only locked achievements, "unlocked" to show
    --      only locked achievements, (or nil)
    --
    -- Returns a sorted list of mini-lists, each in the form
    --      [ACHIEVEMENT_NAME, PROGRESS]
    -- ...where PROGRESS is a value in the range 0 to 1, with 1 meaning the achievement has been
    --      unlocked

    -- Filter out any that we don't want to see
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    local filtered_list = {}
    local secret_list = {}
    local title_table = {}

    for _, achievement_name in ipairs(achievement_list) do

        -- Compile a table of achievement titles, with their escape sequences removed, to be used in
        --      the table.sort() code below
        title_table[achievement_name] = string.lower(
            unilib.utils.clean_translation(
                unilib.global.awards_achievement_table[achievement_name].title
            )
        )

        if mode == nil or
                (mode == "locked" and not unlock_table[achievement_name]) or
                (mode == "unlocked" and unlock_table[achievement_name]) then

            -- Any secret achievements can be moved to a separate list, temporarily
            if not unilib.global.awards_achievement_table[achievement_name]["secret_flag"] then
                table.insert(filtered_list, achievement_name)
            else
                table.insert(secret_list, achievement_name)
            end

        end

    end

    -- Calculate the completion ratio for each achievement
    -- We don't need to do that for secret achievements, since the player's progress in the
    --      achievement shouldn't be visible anyway
    local ratio_table = {}
    local current_table = unilib.global.awards_player_table[pname]["current_table"]
    for _, achievement_name in ipairs(filtered_list) do

        if unlock_table[achievement_name] then

            ratio_table[achievement_name] = 1

        else

            local trigger_table =
                    unilib.global.awards_achievement_table[achievement_name]["trigger_table"]
            if trigger_table.target == nil or current_table[achievement_name] == nil then

                ratio_table[achievement_name] = 0

            else

                ratio_table[achievement_name] =
                        current_table[achievement_name] / trigger_table.target

            end

        end

    end

    -- Calculate the "difficulty" for each achievement (score * target), again omitting secret
    --      achievements
    local difficulty_table = {}
    for _, achievement_name in ipairs(filtered_list) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        difficulty_table[achievement_name] =
                (achievement_table.trigger_table.target or 1) * (achievement_table.score or 10)

    end

    -- Sort "filtered_list" by ratio, then by title
    table.sort(filtered_list, function(a, b)

        if ratio_table[a] ~= ratio_table[b] then
            return ratio_table[a] > ratio_table[b]
        elseif difficulty_table ~= difficulty_table[b] then
            return difficulty_table[a] < difficulty_table[b]
        else
            return title_table[a] < title_table[b]
        end

    end)

    -- Compose the return list, in the format described above
    local return_list = {}
    for _, achievement_name in ipairs(filtered_list) do
        table.insert(return_list, { achievement_name, ratio_table[achievement_name] })
    end

    for _, achievement_name in ipairs(secret_list) do
        table.insert(return_list, { achievement_name, 0 })
    end

    return return_list

end

local function get_achievement_description(pname, achievement_name)

    local achievement_table = unilib.global.awards_achievement_table[achievement_name]
    local trigger_table = achievement_table.trigger_table
    local prototype_table = unilib.global.awards_trigger_prototype_table[trigger_table.prototype]

    if trigger_table.target == 1 then
        return prototype_table.hint_list[1]
    else
        return do_substitution(prototype_table.hint_list[2], trigger_table.target)
    end

end

local function get_achievement_tooltip(pname, achievement_name)

    -- Return a tooltip (as a string) for display above the achievement's gauge, or nil if no
    --      tooltip is available

    if not unilib.setting.awards_tooltips_flag then
        return
    end

    local achievement_table = unilib.global.awards_achievement_table[achievement_name]
    local trigger_table = achievement_table.trigger_table
    local target = trigger_table.target

    local current_table = unilib.global.awards_player_table[pname]["current_table"]
    local current = 0
    if current_table[achievement_name] ~= nil then
        current = current_table[achievement_name]
    end

    local prototype_table = unilib.global.awards_trigger_prototype_table[trigger_table.prototype]
    if target == 1 then
        return do_substitution(prototype_table.progress_list[1], current)
    else
        return do_substitution(prototype_table.progress_list[2], current, target)
    end

end

local function get_achievement_bar(pname, achievement_name, ratio, num, scr_w)

    -- Prepare colours, which depend only on whether the achievement has been unlocked by the player
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    local mini_list, bg_colour, border_colour, text_colour
    if unlock_table[achievement_name] then
        mini_list = ach_colour_table["unlocked"]
    else
        mini_list = ach_colour_table["locked"]
    end

    bg_colour = mini_list[1]
    border_colour = mini_list[2]
    text_colour = mini_list[3]

    -- Prepare the icon and widget sizes/positions
    local achievement_table = unilib.global.awards_achievement_table[achievement_name]

    local img, img_size, img_y_offset, title_offset_y, descrip_offset_y
    if img == nil or achievement_table.secret_flag then

        -- Smaller icon than those used in the vocations tab
        if achievement_table.secret_flag then
            img = "unilib_award_achievement_secret.png"
        elseif unlock_table[achievement_name] then
            img = "unilib_award_achievement_unlocked.png"
        else
            img = "unilib_award_achievement_locked.png"
        end

        if not unlock_table[achievement_name] and not achievement_table.secret_flag then

            -- Gauge visible
            img_size = bar_img_size_small
            img_y_offset = bar_height * bar_img_posn_small
            title_offset_y = bar_title_offset_y
            descrip_offset_y = bar_descrip_offset_y

        else

            -- Gauge not visible
            img_size = bar_img_size_small_nogauge
            img_y_offset = bar_height * bar_img_posn_small_nogauge
            title_offset_y = bar_title_offset_y_nogauge
            descrip_offset_y = bar_descrip_offset_y_nogauge

        end

    else

        -- A custom icon for this achievement, use the same size as icons in the vocations tab
        img = achievement_table.icon
        if not unlock_table[achievement_name] then

            -- Gauge visible
            img_size = bar_img_size
            img_y_offset = bar_height * bar_img_posn
            title_offset_y = bar_title_offset_y
            descrip_offset_y = bar_descrip_offset_y

        else

            -- Gauge not visible
            img_size = bar_img_size_nogauge
            img_y_offset = bar_height * bar_img_posn_nogauge
            title_offset_y = bar_title_offset_y_nogauge
            descrip_offset_y = bar_descrip_offset_y_nogauge

        end

    end

    -- Prepare the title and description, using a description provided by the trigger prototype if
    --      the achievement doesn't specify one
    local title, description
    if not achievement_table.secret_flag then

        title = achievement_table.title
        description = achievement_table.description
        if description == nil or description == "" then
            description = get_achievement_description(pname, achievement_name)
        end

    else

        title = S("Secret Achievement")
        description = S("Unlock this achievement to find out what it is")

    end

    -- Set the bar's height in the scrolling area
    local y = (num - 1) * bar_height

    -- Compose the formspec portion
    local fs_str =
        "box[0," .. y .. ";" .. scr_w .. "," .. bar_height .. ";" .. border_colour .. "]" ..
        "box[" .. bar_padding .. "," .. (y + bar_padding)  .. ";" .. (scr_w - (bar_padding * 2)) ..
            "," .. (bar_height - (bar_padding * 2)) .. ";" .. bg_colour .. "]" ..
        "image[" .. bar_icon_offset_x .. "," .. (y + img_y_offset) .. ";" .. img_size .. "," ..
            img_size .. ";" .. img .. "]" ..
        "hypertext[" .. bar_title_offset_x .. "," .. (y + title_offset_y) .. ";" .. scr_w ..
            "," .. bar_height .. ";title_" .. num .. ";" ..
            "<style color=" .. text_colour .. " size=" .. bar_title_size .. "><b>" ..
            F(title) .. "</b></style>]" ..
        "hypertext[" .. bar_descrip_offset_x .. "," .. (y + descrip_offset_y) .. ";" ..
            scr_w .. "," .. bar_height .. ";descrip_" .. num .. ";" ..
            "<style color=" .. text_colour .. " size=" .. bar_descrip_size .. ">" ..
            F(description) .. "</style>]"

    if not unlock_table[achievement_name] and not achievement_table.secret_flag then

        fs_str = fs_str ..
            "box[" .. bar_gauge_offset_x .. "," .. (y + bar_gauge_offset_y) .. ";" .. (scr_w - 1) ..
                "," .. bar_gauge_height .. ";" .. ach_gauge_bg_colour .. "]" ..
            "box[" .. bar_gauge_offset_x .. "," .. (y + bar_gauge_offset_y) .. ";" ..
                ((scr_w - 1) * ratio) .. "," .. bar_gauge_height .. ";" .. ach_gauge_colour .. "]"

        local tooltip = get_achievement_tooltip(pname, achievement_name)
        if tooltip ~= nil then

            fs_str = fs_str ..
                "tooltip[" .. bar_gauge_offset_x .. "," .. (y + bar_gauge_offset_y) .. ";" ..
                    (scr_w - 1) .. "," .. bar_gauge_height .. ";" .. tooltip .. "]"

        end

    end

    return fs_str

end

local function get_achievements_formspec(pname, vocation_name, mode)

    -- N.B. If "vocation_name" is not specified, then we are showing the "homeless" achievements
    --      that contribute to no vocations
    local title, sorted_achievement_list
    if vocation_name ~= nil then

        local vocation_table = unilib.global.awards_vocation_table[vocation_name]
        if vocation_table == nil then
            return ""
        end

        title = FS("\"@1\" achievements", vocation_table.title)
        sorted_achievement_list = get_sorted_achievement_list(
            pname,
            unilib.awards.get_achievements_by_vocation(vocation_name),
            mode
        )

    else

        title = FS("Other Achievements")
        sorted_achievement_list = get_sorted_achievement_list(
            pname,
            unilib.awards.get_homeless_achievements(),
            mode
        )

    end

    local achievement_count = #sorted_achievement_list

    local unlocked_count = 0
    for _, mini_list in ipairs(sorted_achievement_list) do

        if mini_list[2] == 1 then
            unlocked_count = unlocked_count + 1
        end

    end

    local scr_w = form_width - padding_left - padding_right
    local scr_h = form_height - padding_top - padding_bottom
    local scr_x = padding_left
    local scr_y = padding_top
    local scrollbar_w = padding_right / 2

    local formspec =
        "formspec_version[4]" ..
        "size[" .. form_width .. "," .. form_height .. ";]" ..
        "image[0.25,0.25;1,1;unilib_gui_trophy_comb.png]"

    if mode == "unlocked" then

        -- N.B. The core.register_on_player_receive_fields() code needs to re-open this form with
        --      the same vocation, so pass the vocation name as part of the button name
        local btn_name
        if vocation_name ~= nil then
            btn_name = "ach_btn_filter_unlocked_" .. vocation_name
        else
            btn_name = "ach_btn_filter_unlocked"
        end

        formspec = formspec ..
            "label[1.75,0.75;" .. title .. " (" .. achievement_count .. ")]" ..
            "image_button[" .. (form_width - 2.75) ..
                ",0.3;1,1;unilib_gui_filter_on.png;" .. btn_name .. ";;;false;]" ..
            "tooltip[" .. btn_name .. ";" .. FS("Showing unlocked achievements") .. "]"

    elseif mode == "locked" then

        local btn_name
        if vocation_name ~= nil then
            btn_name = "ach_btn_filter_locked_" .. vocation_name
        else
            btn_name = "ach_btn_filter_locked"
        end

        formspec = formspec ..
            "label[1.75,0.75;" .. title .. " (" .. achievement_count .. ")]" ..
            "image_button[" .. (form_width - 2.75) ..
                ",0.3;1,1;unilib_gui_filter_off.png;" .. btn_name .. ";;;false;]" ..
            "tooltip[" .. btn_name .. ";" .. FS("Showing locked achievements") .. "]"

    else

        local btn_name
        if vocation_name ~= nil then
            btn_name = "ach_btn_filter_all_" .. vocation_name
        else
            btn_name = "ach_btn_filter_all"
        end

        formspec = formspec ..
            "label[1.75,0.75;" .. title .. " (" .. unlocked_count .. "/" ..
                achievement_count .. ")]" ..
            "image_button[" .. (form_width - 2.75) ..
                ",0.3;1,1;unilib_gui_filter_neutral.png;" .. btn_name .. ";;;false;]" ..
            "tooltip[" .. btn_name .. ";" .. FS("Showing all achievements") .. "]"

    end

    formspec = formspec ..
        "image_button[" .. (form_width - 1.5) ..
            ",0.3;1,1;unilib_gui_back.png;ach_btn_back;;;false;]" ..
        "tooltip[ach_btn_back;" .. FS("Go back") .. "]" ..
        "scroll_container[" .. scr_x .. "," .. scr_y .. ";" .. scr_w .. "," .. scr_h ..
            ";scroller;vertical;" ..
            ((achievement_count - award_offset) * (bar_height * 0.001)) .. ";]"

    for num = 1, achievement_count do

        formspec = formspec .. get_achievement_bar(
            pname,
            sorted_achievement_list[num][1],       -- Achievement name
            sorted_achievement_list[num][2],       -- Player's progress in achievement
            num,
            scr_w
        )

    end

    formspec = formspec ..
        "scroll_container_end[]" ..
        "scrollbar[" .. (scr_x + scr_w) .. "," .. scr_y .. ";" .. scrollbar_w .. "," .. scr_h ..
                ";vertical;scroller;0]" ..
        "scrollbaroptions[min=0;max=1000;smallstep=5;largestep=20]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- Local functions (vocations formspec)
---------------------------------------------------------------------------------------------------

local function get_vocation_progress(pname, vocation_name)

    -- Returns the player's progress towards the next level, a value in the range 0-1 (or nil if
    --      the player has already unlocked the top level in this vocation)
    -- e.g. Player's cumulative score in vocation = 60, level 3 score = 40, level 4 score = 80,
    --      player's progress is 50% (returns 0.5)

    -- Highest level unlocked by player in the specified vocation, and their cumulative score in
    --      this vocation so far
    local awards_table = unilib.global.awards_player_table[pname]
    local current_level = awards_table["level_table"][vocation_name]
    if current_level == nil or current_level == 0 then
        return 0
    end

    local current_score = awards_table["score_table"][vocation_name] or 0

    -- Highest level available (don't show a gauage if the player has unlocked all levels)
    local level_list = unilib.global.awards_vocation_table[vocation_name]["level_list"]
    local max_levels = #level_list
    if max_levels == 0 or max_levels <= current_level then
        return nil
    end

    -- Get the score required to unlock the previous level, and the next one
    local prev_score = 0
    local next_score = 0
    for this_level, mini_table in ipairs(level_list) do

        next_score = mini_table.score
        if this_level <= current_level then
            prev_score =mini_table.score
        elseif this_level == current_level + 1 then
            break
        end

    end

    -- Return the progress towards the next level
    return (current_score - prev_score) / (next_score - prev_score)

end

local function get_sorted_vocation_list(pname)

    -- Sort vocations, first by the player's level in that vocation, then by their progress in
    --      the current level, then alphabetically by title
    -- Return a sorted list of mini-lists, each in the form
    --      [VOCATION_NAME, RANK, PROGRESS]
    -- ...where RANK is 1 for the highest level in each vocation (the player has unlocked all
    --      levels), 2 the second-highest (player has unlocked all but one level), and so on; but
    --      0 if the player has not yet unlocked any levels
    -- ...where PROGRESS is a value in the range 0-1, or nil if the player has unlocked all levels
    --      in the vocation

    local rank_table = {}
    local unranked_list = {}
    local highest_rank = 0

    local progress_table = {}
    local sort_progress_table = {}

    local secret_list = {}
    local title_table = {}

    -- Firstly, sort by rank
    for vocation_name, _ in pairs(unilib.global.awards_vocation_table) do

        -- Compile a table of vocation titles, with their escape sequences removed, to be used in
        --      the table.sort() code below
        title_table[vocation_name] = string.lower(
            unilib.utils.clean_translation(
                unilib.global.awards_vocation_table[vocation_name].title
            )
        )

        -- Any vocations without contributing achievements should not be visible in the formspec at
        --      all
        local achievement_list = unilib.awards.get_achievements_by_vocation(vocation_name)
        if #achievement_list > 0 then

            -- Any secret vocations can be moved to a separate list, temporarily
            if unilib.global.awards_vocation_table[vocation_name]["secret_flag"] then

                table.insert(secret_list, vocation_name)

            else

                local level_table = unilib.global.awards_player_table[pname]["level_table"]
                local vocation_table = unilib.global.awards_vocation_table[vocation_name]
                if vocation_table and level_table[vocation_name] then

                    local rank = #vocation_table.level_list - level_table[vocation_name] + 1
                    -- N.B. use rank = 0 (not 13) when the player's level in the vocation is 0
                    if rank > #vocation_table.level_list then
                        rank = 0
                    end

                    if highest_rank < rank then
                        highest_rank = rank
                    end

                    if rank_table[rank] ~= nil then
                        table.insert(rank_table[rank], vocation_name)
                    else
                        rank_table[rank] = {vocation_name}
                    end

                else

                    -- Use a separate list for vocations which have no unlocked levels
                    table.insert(unranked_list, vocation_name)

                end

                -- While we're at it, calculate the player's progress in the current level
                progress_table[vocation_name] = get_vocation_progress(pname, vocation_name)
                -- The sorting algorithms are much simpler when sorting values that are not nil
                sort_progress_table[vocation_name] = progress_table[vocation_name] or 0

            end

        end

    end

    -- Add ranked vocations to the return list, sorted by rank, then by progress, then by title
    local return_list = {}
    for rank = 1, highest_rank do

        if rank_table[rank] ~= nil then

            table.sort(rank_table[rank], function(a, b)

                if sort_progress_table[a] == sort_progress_table[b] then
                    return title_table[a] < title_table[b]
                else
                    return sort_progress_table[a] > sort_progress_table[b]
                end

            end)

            for _, vocation_name in ipairs(rank_table[rank]) do
                table.insert(return_list, {vocation_name, rank, progress_table[vocation_name]})
            end

        end

    end

    -- Add unranked vocations to the return list, sorted by title
    table.sort(unranked_list, function(a, b)

        if sort_progress_table[a] == sort_progress_table[b] then
            return title_table[a] < title_table[b]
        else
            return sort_progress_table[a] > sort_progress_table[b]
        end

    end)

    for _, vocation_name in ipairs(unranked_list) do
        table.insert(return_list, {vocation_name, 0, progress_table[vocation_name]})
    end

    -- Finally add secret vocations to the return list, in no particular order and with zero values
    --      for RANK and PROGRESS, since they aren't visible anyway
    for _, vocation_name in ipairs(secret_list) do
        table.insert(return_list, {vocation_name, 0, 0})
    end

    -- Operation complete
    return return_list

end

local function get_vocation_tooltip(pname, vocation_name, ratio)

    -- Return a tooltip (as a string) for display above the achievement's gauge, or nil if no
    --      tooltip is available

    if not unilib.setting.awards_tooltips_flag then
        return
    end

    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]

    local achievement_list = unilib.awards.get_achievements_by_vocation(vocation_name)
    if not #achievement_list then
        return
    end

    local unlocked_count = 0
    for _, achievement_name in ipairs(achievement_list) do

        if unlock_table[achievement_name] then
            unlocked_count = unlocked_count + 1
        end

    end

    return S("@1/@2 achievements unlocked", unlocked_count, #achievement_list) .. "\n" ..
            S("Progress towards next level: @1%", math.floor(ratio * 100))

end

local function get_vocation_bar(pname, vocation_name, rank, ratio, num, scr_w)

    -- Prepare colours, which depend on the player's rank in the vocation
    local mini_list, bg_colour, border_colour, text_colour
    if rank == 1 then
        mini_list = vcn_colour_list.gold
    elseif rank == 2 then
        mini_list = vcn_colour_list.silver
    elseif rank == 3 then
        mini_list = vcn_colour_list.bronze
    elseif rank == 0 then
        mini_list = vcn_colour_list.bottom
    else
        mini_list = vcn_colour_list.other
    end

    bg_colour = mini_list[1]
    border_colour = mini_list[2]
    text_colour = mini_list[3]

    -- Prepare the icon
    local vocation_table = unilib.global.awards_vocation_table[vocation_name]
    local level_table = unilib.global.awards_player_table[pname]["level_table"]

    local img = vocation_table.icon or "unilib_award_vocation_default.png"
    if vocation_table.secret_flag then
        img = "unilib_award_vocation_secret.png"
    end

    -- Prepare the title and description
    local title, description, extra
    if not vocation_table.secret_flag then

        title = vocation_table.title
        description = vocation_table.description
        if level_table[vocation_name] then
            extra = "  " .. level_table[vocation_name] .. "/" .. #vocation_table.level_list
        else
            extra = ""
        end

    else

        title = S("Secret Award")
        description = S("Unlock the first level of this award to find out what it is")
        extra = ""

    end

    -- Set widget positions in the scrolling area
    local y = (num - 1) * bar_height
    local title_offset_y, descrip_offset_y, img_size, img_y_offset
    if ratio ~= nil and not vocation_table.secret_flag then

         title_offset_y = bar_title_offset_y
         descrip_offset_y = bar_descrip_offset_y
         img_size = bar_img_size
         img_y_offset = bar_height * bar_img_posn

    else

         title_offset_y = bar_title_offset_y_nogauge
         descrip_offset_y = bar_descrip_offset_y_nogauge
         img_size = bar_img_size_nogauge
         img_y_offset = bar_height *  bar_img_posn_nogauge

    end

    -- Compose the formspec portion
    local fs_str =
        "box[0," .. y .. ";" .. scr_w .. "," .. bar_height .. ";" .. border_colour .. "]" ..
        "box[" .. bar_padding .. "," .. (y + bar_padding)  .. ";" .. (scr_w - (bar_padding * 2)) ..
            "," .. (bar_height - (bar_padding * 2)) .. ";" .. bg_colour .. "]" ..
        "image[" .. bar_icon_offset_x .. "," .. (y + img_y_offset) .. ";" ..
            img_size .. "," .. img_size .. ";" .. img .. "]" ..
        "hypertext[" .. bar_title_offset_x .. "," .. (y + title_offset_y) .. ";" .. scr_w ..
            "," .. bar_height .. ";title_" .. num .. ";" ..
            "<style color=" .. text_colour .. " size=" .. bar_title_size .. "><b>" ..
            F(title) .. "</b>" .. extra .. "</style>]" ..
        "hypertext[" .. bar_descrip_offset_x .. "," .. (y + descrip_offset_y) .. ";" ..
            scr_w .. "," .. bar_height .. ";descrip_" .. num .. ";" ..
            "<style color=" .. text_colour .. " size=" .. bar_descrip_size .. ">" ..
            F(description) .. "</style>]"

    if ratio ~= nil and not vocation_table.secret_flag then

        fs_str = fs_str ..
            "image_button[" .. (scr_w - 1.5) .. "," .. (y + img_y_offset) ..
                ";" .. bar_img_size .. "," .. bar_img_size .. ";unilib_gui_info.png;vcn_btn_" ..
                vocation_name .. ";;;false;]" ..
            "tooltip[vcn_btn_" .. vocation_name .. ";" .. FS("Show achievements") .. "]" ..
            "box[" .. bar_gauge_offset_x .. "," .. (y + bar_gauge_offset_y) .. ";" ..
                (scr_w - 1) .. "," .. bar_gauge_height .. ";" .. vcn_gauge_bg_colour .. "]" ..
            "box[" .. bar_gauge_offset_x .. "," .. (y + bar_gauge_offset_y) .. ";" ..
                ((scr_w - 1) * ratio) .. "," .. bar_gauge_height .. ";" .. vcn_gauge_colour .. "]"

        local tooltip = get_vocation_tooltip(pname, vocation_name, ratio)
        if tooltip ~= nil then

            fs_str = fs_str ..
                "tooltip[" .. bar_gauge_offset_x .. "," .. (y + bar_gauge_offset_y) .. ";" ..
                (scr_w - 1) .. "," .. bar_gauge_height .. ";" .. tooltip .. "]"

        end

    end

    return fs_str

end

local function get_homeless_bar(pname, num, scr_w)

    -- Prepare colours
    local mini_list = vcn_colour_list.special
    local bg_colour = mini_list[1]
    local border_colour = mini_list[2]
    local text_colour = mini_list[3]

    -- Prepare the icon
    local img = "unilib_award_vocation_default.png"
    local img_size = bar_img_size_special
    local img_y_offset = bar_height * bar_img_posn_special

    -- Set the bar's height in the scrolling area
    local y = (num - 1) * bar_height

    -- Compose the formspec portion
    local fs_str =
        "box[0," .. y .. ";" .. scr_w .. "," .. bar_height .. ";" .. border_colour .. "]" ..
        "box[" .. bar_padding .. "," .. (y + bar_padding)  .. ";" .. (scr_w - (bar_padding * 2)) ..
            "," .. (bar_height - (bar_padding * 2)) .. ";" .. bg_colour .. "]" ..
        "image[" .. bar_icon_offset_x .. "," .. (y + img_y_offset) .. ";" ..
            img_size .. "," .. img_size .. ";" .. img .. "]" ..
        "hypertext[" .. bar_title_offset_x .. "," .. (y + bar_title_offset_y_special) .. ";" ..
            scr_w .. "," .. bar_height .. ";title_" .. num .. ";" ..
            "<style color=" .. text_colour .. " size=" .. bar_title_size .. "><b>" ..
            FS("Other Achievements") .. "</b>" .. "</style>]" ..
        "image_button[" .. (scr_w - 1.5) .. "," .. (y + img_y_offset) ..
            ";1,1;unilib_gui_info.png;vcn_btn;;;false;]" ..
        "tooltip[vcn_btn;" .. FS("Show achievements") .. "]"

    return fs_str

end

local function get_vocations_formspec(pname)

    local sorted_vocation_list = get_sorted_vocation_list(pname)
    local vocation_count = #sorted_vocation_list

    -- If there are any "homeless" achievements not contributing to vocations, add a special bar at
    --      the bottom of the list
    local bar_count = vocation_count
    local homeless_achievement_list = unilib.awards.get_homeless_achievements()
    if #homeless_achievement_list > 0 then
        bar_count = bar_count + 1
    end

    -- Number of trophies (for reaching the highest levels in a vocation), in the form
    --      [gold, silver, bronze, at_least_one, zero]
    local trophy_list = {0, 0, 0, 0, 0}
    for _, mini_list in ipairs(sorted_vocation_list) do

        local rank = mini_list[2]
        if rank == 1 then
            trophy_list[1] = trophy_list[1] + 1
        elseif rank == 2 then
            trophy_list[2] = trophy_list[2] + 1
        elseif rank == 3 then
            trophy_list[3] = trophy_list[3] + 1
        elseif rank > 0 then
            trophy_list[4] = trophy_list[4] + 1
        else
            trophy_list[5] = trophy_list[5] + 1
        end

    end

    local scr_w = form_width - padding_left - padding_right
    local scr_h = form_height - padding_top - padding_bottom
    local scr_x = padding_left
    local scr_y = padding_top
    local scrollbar_w = padding_right / 2

    local formspec =
        "formspec_version[4]" ..
        "size[" .. form_width .. "," .. form_height .. ";]" ..
        "image[0.25,0.25;1,1;unilib_gui_trophy_comb.png]" ..
        "label[1.75,0.75;" .. FS("Awards for @1", pname) .. "]"

    for i, trophy_type in ipairs({"gold", "silver", "bronze", "misc", "default"}) do

        local offset = form_width - 6.5 + i

        formspec = formspec ..
            "image[" .. offset .. ",0.5;0.5,0.5;unilib_gui_trophy_" .. trophy_type .. ".png]" ..
            "label[" .. (offset + 0.6) .. ",0.75;" .. FS(tostring(trophy_list[i])) .. "]"

    end

    formspec = formspec ..
        "scroll_container[" .. scr_x .. "," .. scr_y .. ";" .. scr_w .. "," .. scr_h ..
            ";scroller;vertical;" ..
            ((bar_count - award_offset) * (bar_height * 0.001)) .. ";]"

    for num = 1, vocation_count do

        formspec = formspec .. get_vocation_bar(
            pname,
            sorted_vocation_list[num][1],       -- Vocation name
            sorted_vocation_list[num][2],       -- Player's rank in vocation (1 = highest level)
            sorted_vocation_list[num][3],       -- Player progress in current level (0-1)
            num,
            scr_w
        )

    end

    if bar_count ~= vocation_count then
        formspec = formspec .. get_homeless_bar(pname, bar_count, scr_w)
    end

    formspec = formspec ..
        "scroll_container_end[]" ..
        "scrollbar[" .. (scr_x + scr_w) .. "," .. scr_y .. ";" .. scrollbar_w .. "," .. scr_h ..
                ";vertical;scroller;0]" ..
        "scrollbaroptions[min=0;max=1000;smallstep=5;largestep=20]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.awards.show_formspec(pname)
    core.show_formspec(pname, vcn_formname, get_vocations_formspec(pname))
end

---------------------------------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------------------------------

core.register_on_player_receive_fields(function(player, formname, fields)

    if formname ~= vcn_formname and formname ~= ach_formname then
        return false
    end

    local pname = player:get_player_name()

    if formname == vcn_formname then

        if fields.vcn_btn then

            -- Information button was clicked; open the achievements formspec for "homeless"
            --      achievements
            return core.show_formspec(
                pname,
                ach_formname,
                get_achievements_formspec(pname)
            )

        end

        for vocation_name, _ in pairs(unilib.global.awards_vocation_table) do

            if fields["vcn_btn_" .. vocation_name] then

                -- Information button was clicked; open the achievements formspec for the specified
                --      vocation
                return core.show_formspec(
                    pname,
                    ach_formname,
                    get_achievements_formspec(pname, vocation_name)
                )

            end

        end

    elseif formname == ach_formname then

        -- Re-open the vocations formspec
        if fields.ach_btn_back then
            return core.show_formspec(pname, vcn_formname, get_vocations_formspec(pname))
        end

        -- Re-display the formspec for "homeless" achievements, with a different filter
        if fields.ach_btn_filter_unlocked then

            return core.show_formspec(
                pname, ach_formname, get_achievements_formspec(pname, nil, "locked")
            )

        elseif fields.ach_btn_filter_locked then

            return core.show_formspec(
                pname, ach_formname, get_achievements_formspec(pname, nil, nil)
            )

        elseif fields.ach_btn_filter_all then

            return core.show_formspec(
                pname, ach_formname, get_achievements_formspec(pname, nil, "unlocked")
            )

        end

        -- Re-display the achievements formspec for everything else, with a different filter
        for vocation_name, _ in pairs(unilib.global.awards_vocation_table) do

            if fields["ach_btn_filter_unlocked_" .. vocation_name] then

                return core.show_formspec(
                    pname, ach_formname, get_achievements_formspec(pname, vocation_name, "locked")
                )

            elseif fields["ach_btn_filter_locked_" .. vocation_name] then

                return core.show_formspec(
                    pname, ach_formname, get_achievements_formspec(pname, vocation_name, nil)
                )

            elseif fields["ach_btn_filter_all_" .. vocation_name] then

                return core.show_formspec(
                    pname, ach_formname, get_achievements_formspec(pname, vocation_name, "unlocked")
                )

            end

        end

    end

end)
