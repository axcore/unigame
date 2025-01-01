---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hud_base.lua
--      Base API functions for the unilib HUD
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- unilib organises its HUDs in the following groups:
--      - Top of the screen - eye candy, such as the minimap and the output of
--          ../lib/effects/identify/identify_base.lua. Clashes with the chat window, if visible
--      - Bottom of the screen - stat counters such as the health bar
--      - Middle of the screen - all text HUDs, which are handled by unilib's Standard HUD, as
--          described below. Note the Minetest setting unilib.setting.hud_standard_posn, which moves
--          the text closer to the top, or closer to the bottom
--      - Anywhere: graphical HUDs that are expected to be centred in the middle of the screen, such
--          as the hangglider, anvils and threshing machines
--
-- Packages are free to place their HUDs anywhere in the screen, following the arrangment above.
--      It's understood, for example, that the hangglider and anvil HUDs can't be visible at the
--      same time, so there's no need to worry about whether they'll overlap
-- Text HUDs are a different matter, however. All text HUDs should be handled by the Standard HUD,
--      so that they can be grouped together in one area of the screen (and will therefore not
--      overlap each other)
--
-- The Standard HUD, containing text only, is divided into HUD Sections. Each HUD Section is created
--      for a particular package (or group) of packages
-- HUD Sections should have a unique name, usually the same as the name of the calling package, and
--      are displayed in alphabetical order (so you could ensure that a HUD Section is displayed
--      first by naming it "1_PACKAGE_NAME" or something like that)
-- HUD Sections are numbered sequentially, with the first in the alphabetical list being #1. When
--      HUD Sections are added/removed, all numbers are recalculated to preserve the alphabetical
--      order (but their names don't change)
-- Packages using the Standard HUD are responsible for deciding when to start showing the HUD
--      Section to a player - which includes detecting when the player joins the server, or when
--      they wield a certain item, as applicable. However, the code here will automatically check
--      for players leaving a server
--
-- To add and remove HUD Sections, use unilib.hud.add_section() and unilib.hud.remove_section().
--      To set the text displayed in a single line of a HUD Section, use unilib.hud.update_line()
--
-- A HUD Section is represented by a table in the form
--      {
--          name = section_name
--          number = section_number
--          line_count = number_of_HUD_Lines_in_this_section
--          line_list = list_of_HUD_Lines
--          offset = number_of_HUD_Lines_in_previous_sections
--      }
--
-- A HUD Line represents a single line of text in the HUD. It is represented as a table in the form
--      {
--          colour = RGB, e.g. 0xFFFFFF
--          id = Minetest_HUD_ID
--          text = text_to_display
--      }
--
-- Table of HUD Sections, in the form
--      main_table[player_name][section_number] = section_table
local main_table = {}
-- Table of HUD Section names and their corresponding HUD Section numbers, in the form
--      convert_table[player_name][section_name] = section_number
local convert_table = {}
-- Total number of HUD Lines in operation
local total_lines = 0

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function add_line(player, pname, section_name, line_number, text, colour)

    local position, offset
    if unilib.setting.hud_standard_posn == "top" then

        position = {x = 0.5, y = 0.025}
        offset = {x = 0, y = 20 * (line_number - 1)}

    elseif unilib.setting.hud_standard_posn == "bottom" then

        position = {x = 0.5, y = 0.85}
        offset = {x = 0, y = 20 * (total_lines - line_number + 1) * -1}

    else

        position = {x = 0.5, y = 0.225}
        offset = {x = 0, y = 20 * (line_number - 1)}

    end

    return player:hud_add({
        name = "standard_hud_" .. pname .. "_" .. section_name,
        type = "text",

        alignment = {x = 0, y = 0},
        number = colour,
        offset = offset,
        position = position,
        text = text,
        z_index = 0,
    })

end

local function remove_line(player, id)

    return player:hud_remove(id)

end

local function clear_display(player, pname)

    if main_table[pname] == nil then
        return
    end

    -- Remove all previous lines
    for _, section_table in ipairs (main_table[pname]) do

        for _, line_table in ipairs(section_table.line_list) do
            remove_line(player, line_table.id)
        end

    end

end

local function update_display(player, pname)

    if main_table[pname] == nil then
        return
    end

    -- Create new lines, using the same text
    for _, section_table in ipairs (main_table[pname]) do

        for i, line_table in ipairs(section_table.line_list) do

            line_table.id = add_line(
                player,
                pname,
                section_table.name,
                section_table.offset + i,
                line_table.text,
                line_table.colour
            )

        end

    end

end

local function renumber_huds(pname)

    local sorted_name_list = unilib.utils.sort_table(convert_table[pname])
    local previous_section_count = #sorted_name_list

    local new_main_table = {}
    local new_convert_table = {}
    local section_count = 0

    total_lines = 0

    for _, this_name in ipairs(sorted_name_list) do

        local this_number = convert_table[pname][this_name]
        local section_table = main_table[pname][this_number]
        if section_table ~= nil then

            section_count = section_count + 1
            section_table.number = section_count
            section_table.offset = total_lines
            total_lines = total_lines + section_table.line_count

            table.insert(new_main_table, section_table)
            new_convert_table[section_table.name] = section_count

        end

    end

    main_table[pname] = new_main_table
    convert_table[pname] = new_convert_table

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.hud._add_section(player, section_name, line_count)

    -- Initialise registries
    local pname = player:get_player_name()
    if main_table[pname] == nil then

        main_table[pname] = {}
        convert_table[pname] = {}

    end

    -- Basic checks. A duplicate name does not create a new section, but is ignored
    if section_name == nil or
            section_name == "" or
            line_count == nil or
            line_count < 1 or
            convert_table[pname][section_name] ~= nil then

        return false

    end

    -- Clear the display, in case the order of HUD Sections changes
    clear_display(player, pname)

    -- Create new HUD Lines. The call to add_line() isn't necessary, because another one will be
    --      made during the call to update_display() below
    local line_list = {}
    for i = 1, line_count do

        table.insert(line_list, {
            colour = 0xFFFFFF,
--          id = add_line(player, pname, section_name, total_lines + i, "", 0xFFFFFF),
            text = "",
        })

    end

    local previous_total = total_lines
    total_lines = total_lines + line_count

    -- Create a new HUD Section, at the end of the list
    local section_number = #main_table[pname] + 1
    local this_section_table = {
        name = section_name,
        number = section_number,
        line_count = #line_list,
        line_list = line_list,
        offset = previous_total,
    }

    main_table[pname][section_number] = this_section_table
    convert_table[pname][section_name] = section_number

    -- Renumber all HUD Sections, and update the table
    if previous_total > 0 then
        renumber_huds(pname)
    end

    update_display(player, pname)

end

function unilib.hud._remove_section(player, section_name)

    -- Basic checks
    local pname = player:get_player_name()
    if main_table[pname] == nil then
        return
    end

    local section_number = convert_table[pname][section_name]
    if section_number == nil then
        return
    end

    -- Remove the HUD section, update registries and the display
    clear_display(player, pname)
    main_table[pname][section_number] = nil
    renumber_huds(pname)
    update_display(player, pname)

end

function unilib.hud._update_line(player, section_name, line_number, optional_text, optional_colour)

    -- Basic checks
    local pname = player:get_player_name()
    if main_table[pname] == nil then
        return
    end

    local section_number = convert_table[pname][section_name]
    if section_number == nil then
        return
    end

    local section_table = main_table[pname][section_number]
    if section_table == nil or line_number > section_table.line_count then
        return
    end

    local this_line_table = section_table["line_list"][line_number]
    if this_line_table == nil then
        return
    end

    -- Update the text of a HUD Line
    if optional_text == nil then
        optional_text = ""
    end

    this_line_table.text = optional_text
    player:hud_change(this_line_table.id, "text", optional_text)

    if optional_colour ~= nil and unilib.setting.hud_standard_colour_flag then

        this_line_table.colour = optional_colour
        player:hud_change(this_line_table.id, "number", optional_colour)

    end

end

---------------------------------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------------------------------

core.register_on_leaveplayer(function(player)

    local pname = player:get_player_name()
    main_table[pname] = nil
    convert_table[pname] = nil

end)
