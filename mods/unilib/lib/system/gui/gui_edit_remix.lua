---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- gui_edit.lua
--      API functions for the remix editing formspec
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local edit_formname = "unilib:form_system_gui_edit"
local confirm_formname = "unilib:form_system_gui_edit_confirm"

-- List of visible tabs (populated below)
-- Format: a list of tab types (a selection of the keys in "tab_defn_table"), one for each visible
--      tab. Only one tab of each category can be added to this list (so although there are 6 ore
--      tabs, only one is visible at any time)
local tab_display_list = {}
-- Table of tabs (populated below), defining the characteristics of each tab
-- Format: tab_defn_table[tab_type] = mini_table
--      ...where mini_table has some compulsory key-value pairs, and any number of optional ones
--          (including the optional ones described below)
--
-- Compulsory key-value pairs:
--
--      category = CATEGORY_TYPE
--          CATEGORY_TYPE is any string; multiple tabs can share the same CATEGORY_TYPE
--      label = TAB_LABEL
--          TAB_LABEL is the text visible on the tab, e.g. "Packages"
--      file = FILE_NAME
--          FILE_NAME is the file loaded and saved by this tab, e.g. "packages.csv"
--
-- Optional key-value pairs:
--
--      init_func = FUNCTION
--          FUNCTION called when the formspec is first opened, or when the formspec is opened to
--              edit a new remix; it resets the contents of "tab_data_table". If the tab doesn't
--              specify a FUNCTION, then tab_data_table is given a .content field, set to the
--              current contents of the file (if it exists), or set to nil if not
--      formspec_func = FUNCTION
--          FUNCTION called whenever the formspec is drawn, with this tab the visible one. Returns
--              a string that's added to the formspec definition, just before that definition is
--              passed to the engine for display. If the tab doesn't specify a FUNCTION, then
--              nothing needs to be added to the formspec definition (as is the case for the
--              "description" tab)
--      storage_func = FUNCTION
--          FUNCTION called whenever the user interacts with the formspec; it stores data (such as
--              all of the entered into the current tab), so that it's still available the next
--              time the same tab is visible. If the tab doesn't specify a FUNCTION, then there is
--              no data to store
--      response_func = FUNCTION
--          FUNCTION called whenever the user interacts with the formspec; it decides what to do, in
--              response. This function must place another call to core.show_formspec(), if the
--              formspec is to remain open. If the tab doesn't specify a FUNCTION, then nothing
--              happens, and the formspec is closed
--      convert_func = FUNCTION
--          FUNCTION called whenever the player clicks the "Convert line of text..." button at the
--              top of the formspec, and then enters some text in the new field, either pressing
--              ENTER or clicking the "Convert" button. The line of text should match the format
--              used by the CSV file; the data it contains is added to the fields below the notepad
--
--      add_constant_label = STRING
--      add_constant_func = FUNCTION
--          If both are specified, the "Constants" tab adds a button in the form STRING, e.g.
--              "Add biome constants"; when clicked, the FUNCTION is called
--
--      warning_tooltip = STRING
--      warning_call_func = FUNCTION
--      warning_check_func = FUNCTION
--          If the first FUNCTION ("warning_call_func") is specified, than a button with a warning
--              icon may be added to the top row of the formspec
--          The button is added if the second FUNCTION ("warning_check_func") is not specified, or
--              if it is specified and returns true, when called
--          When clicked, the button calls the first FUNCTION ("warning_call_func")
--          STRING is optional; if specified, it's used as the button's tooltip
--          It's expected that clicking this button may open a different formspec, so the current
--              formspec is not re-displayed automatically
--
--      constant_table = TABLE
--          Table of constants to be added to various fields, when the user clicks the button. The
--              keys partially match the name of the field to be filled; the corresponding values
--              are the constant itself, e.g. "NO_MAX_HEIGHT"
--      extra_constant_table = TABLE
--          An additional table of constants, typically for use when several tabs share the same
--              category (as is the case for the ore tabs)
--      prop_list = LIST
--          A list of properties, representing keys in "tab_data_table". Used to quickly set those
--              key-value pairs (e.g. to nil, or to a constant value like "NO_MAX_HEIGHT")
--      extra_prop_list = LIST
--          An additional list of properties, typically for use when several tabs shared the same
--              category (as is the case for the ore tabs)
--
--      type_list = LIST
--          A list of items typically used for handling dropboxes
--      type_list_index = INT
--          The index of the visible item in a dropbox (not required by all dropboxes)
--
local tab_defn_table = {}
-- Table of tables (populated below), containing  current data for each tab; this table contains
--      exactly the same aset of keys as "tab_defn_table"
local tab_data_table = {}
-- A table of formspec buttons and functions to call, when the buttons are clicked
-- Currently used only by the "Constants" tab for its customisable list of buttons
local button_func_table = {}

-- Default tables for ore tabs
local default_ore_constant_table = {
    ore_param2 = "NO_PARAM2",
    ore_wherein = "NO_WHEREIN",
    ore_scarcity = "NO_CLUST_SCARCITY",
    ore_num = "NO_CLUST_NUM",
    ore_size = "NO_CLUST_SIZE",
    ore_max = "NO_MAX_HEIGHT",
    ore_min = "NO_MIN_HEIGHT",
    ore_flags = "NO_FLAGS",
    ore_threshold = "NO_THRESHOLD",
    ore_np_offset = "NO_NP_OFFSET",
    ore_np_scale = "NO_NP_SCALE",
    ore_np_spread = "NO_NP_SPREAD",
    ore_np_seed = "NO_NP_SEED",
    ore_np_octaves = "NO_NP_OCTAVES",
    ore_np_persist = "NO_NP_PERSIST",
    ore_biomes = "NO_BIOMES",
}
local default_ore_type_list = {"blob", "puff", "scatter", "sheet", "stratum", "vein"}
local default_ore_prop_list = {
    "ore_name", "ore_wherein", "ore_biomes", "ore_scarcity", "ore_num", "ore_size", "ore_max",
    "ore_min", "ore_flags", "ore_threshold", "ore_param2", "ore_np_offset", "ore_np_scale",
    "ore_np_spread", "ore_np_seed", "ore_np_octaves", "ore_np_persist",
}

-- Complete list of package names, populated below
local all_pkg_list = nil
-- Partial list of package names, populated below
local select_pkg_list = nil

-- (Current state of all tabs)
-- The name of the remix currently being edited
local current_remix_name = nil
-- The number of the current tab, matching an index in tab_display_list
local current_tab = nil
-- A string used by get_edit_formspec() to guarantee that the visible formspec is re-drawn
local current_invisible_text = ""
-- Flag set to true, when the main notepad is to be split, with an area below it for converting
--      CSV text into separate fields
local split_notepad_flag = false

-- (Miscellaneous variables)
local light_colour = "#D3D3D3"
local which_msg = S("Edit which remix? (Try /create_remix)")

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.gui.convert_fields_msg = FS("Convert line of text into separate fields")
unilib.gui.empty_fields_msg = FS("Empty the fields below")
unilib.gui.insert_constants_msg = FS("Insert standard constants into the fields below")

---------------------------------------------------------------------------------------------------
-- Local functions (utility functions)
---------------------------------------------------------------------------------------------------

local function compile_pkg_list()

    -- (Stripped-down version of the same function in ../lib/system/gui/gui_main.lua)

    -- This list only needs to be compiled once
    if all_pkg_list == nil then

        all_pkg_list = {}

        -- Packages with duplicate names are never loaded
        local check_table = {}

        -- The first time the formspec tab is opened, compile a list of all available packages (not
        --      just those that have been loaded)
        for _, folder_path in ipairs(unilib.global.pkg_path_list) do

            for _, file_name in ipairs(core.get_dir_list(folder_path, false)) do

                -- Not really practical to check that this is a genuine unilib package at this
                --      stage, but at least check that it's a .lua file
                if file_name:sub(-4) == ".lua" then
                    table.insert(all_pkg_list, file_name:sub(1, -5))
                end

            end

        end

        table.sort(all_pkg_list)

    end

    if select_pkg_list ~= nil then
        return table.concat(select_pkg_list, ",")
    else
        return table.concat(all_pkg_list, ",")
    end

end

local function do_pkg_search(search_term)

    if all_pkg_list == nil or search_term == nil or search_term == "" then

        -- Nothing to search
        select_pkg_list = nil
        return

    end

    select_pkg_list = {}
    for _, pkg_name in ipairs(all_pkg_list) do

        if pkg_name:find(search_term) then
            table.insert(select_pkg_list, pkg_name)
        end

    end

end

local function find_index_in_list(list, arg)

    for i, v in ipairs(list) do

        if arg == v then
            return i
        end

    end

end

local function get_path(remix_name, file_name)

    -- Return the path to a remix folder in Minetest mod storage, or optionally a file within that
    --      folder
    local path = unilib.core.path_mod_data .."/remixes/" .. remix_name .. "/"
    if file_name ~= nil then
        path = path .. file_name
    end

    return path

end

local function insert_tab(category, tab_type)

    -- Inserts an item "tab_type" into "tab_display_list", but only if an item of the same category
    --      is not already there

    for _, this_tab_type in ipairs(tab_display_list) do

        if tab_defn_table[this_tab_type]["category"] == category then
            return
        end

    end

    table.insert(tab_display_list, tab_type)

end

local function substitute_tab(category, tab_type)

    -- Substitutes an item in "tab_display_list", with an item ("tab_type") of the same category

    for i = 1, #tab_display_list do

        local this_tab_type = tab_display_list[i]
        local this_category = tab_defn_table[this_tab_type]["category"]
        if this_category == category then

            tab_display_list[i] = tab_type
            return

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (file handling)
---------------------------------------------------------------------------------------------------

local function load_file(remix_name, tab_type)

    local path = get_path(remix_name, tab_defn_table[tab_type]["file"])
    if unilib.utils.is_file(path) then

        local file = io.open(path, "rb")
        if file then

            local content = file:read("*all")
            file:close()

            return content

        end

    end

    -- Success can be shown by returning a string, empty or not; failure is shown by returning nil
    return nil

end

local function save_file(file_name, content)

    local path = get_path(current_remix_name, file_name)
    local file = io.open(path, "w")
    if file then

        file:write(tostring(content))
        file:close()

        return true

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (compose the formspecs)
---------------------------------------------------------------------------------------------------

local function get_tab_labels()

    local str = ""
    for _, tab_type in ipairs(tab_display_list) do

        if str ~= "" then
            str = str .. ","
        end

        str = str .. tab_defn_table[tab_type]["label"]

    end

    return str

end

local function get_package_formspec_section(tab_type)

    local formspec =
        "label[1.2,0.2;" .. FS("Add packages to remix \"@1\"", current_remix_name) .. "]" ..
        "textarea[0.3,3.8;5.5,2;;;" ..
            FS("Add packages to the remix by") .. ":\n\n" ..
            "- " .. FS("Typing them directly into the box above") .. "\n" ..
            "- " .. FS("Typing them, one at a time, into the box below") .. "\n" ..
            "- " .. FS("Double-clicking items in the list on the right") ..
            "]" ..
        "field[0.35,6.1;5,1;pkg_name_field;" .. FS("Package name") .. ";]" ..
        "field_close_on_enter[pkg_name_field;false]" ..
        "tooltip[pkg_name_field;" .. F("e.g. stone_ordinary") .. "]" ..
        "field[0.35,7.3;5,1;pkg_mod_field;" .. FS("Original mod name(s) (optional)") .. ";" ..
            tab_data_table[tab_type]["pkg_mod"] .. "]" ..
        "field_close_on_enter[pkg_mod_field;false]" ..
        "tooltip[pkg_mod_field;" .. F("e.g. default moreblocks technic") .. "]" ..
        "textarea[0.3,8;5.5,2;;;" ..
            FS(
                "(If you specify the original mod(s), the text you type in the box above" ..
                " must match exactly the text used by other remixes)"
            ) ..
            "]" ..
        "field[5.7,4;2.5,1;pkg_search_field;;" ..
            F(tab_data_table[tab_type]["pkg_search"]) .. "]" ..
        "field_close_on_enter[pkg_search_field;false]" ..
        "tooltip[pkg_search_field;" .. FS("Enter regex") .. "]" ..
        "image_button[7.8,3.8;0.8,0.8;unilib_gui_search.png;pkg_search_btn;;;]" ..
        "tooltip[pkg_search_btn;" .. FS("Search the list of packages") .. "]" ..
        "image_button[8.5,3.8;0.8,0.8;unilib_gui_unsearch.png;pkg_unsearch_btn;;;]" ..
        "tooltip[pkg_unsearch_btn;" .. FS("Reset the search") .. "]" ..
        "image_button[9.2,3.8;0.8,0.8;unilib_gui_refresh.png;pkg_reload_btn;;;]" ..
        "tooltip[pkg_reload_btn;" .. FS("Reload the list of packages") .. "]" ..
        "textlist[5.4,4.9;4.4,5.1;pkg_name_list;" .. compile_pkg_list() .. "]"

    return formspec

end

local function get_description_formspec_section(tab_type)

    local formspec =
        "label[1.2,0.2;" ..
            FS("Write a description for remix \"@1\"", current_remix_name) .. "]" ..
        "textarea[0.5,4;9.5,4;;;" ..
            FS("Remix descriptions are optional. They can contain any text.") .. "]"

    return formspec

end

local function get_label_formspec_section(tab_type)

    local formspec =
        "label[1.2,0.2;" ..
            FS("Add remix labels to \"@1\"", current_remix_name) .. "]" ..
        "textarea[0.5,4;9.5,4;;;" ..
            FS(
                "Remix labels tell certain packages which remixes contain the data that they" ..
                " can read. See the unilib documentation for more information."
            ) .. "]"

    return formspec

end

local function get_constant_formspec_section(tab_type)

    -- Widgets that are always present
    local formspec =
        "label[1.2,0.2;" ..
            FS("Add constants to remix \"@1\"", current_remix_name) .. "]" ..
        "field[0.3,4.2;4.6,1;constant_name_field;" .. FS("Constant name") .. ";" ..
            tab_data_table[tab_type]["constant_name"] .. "]" ..
        "field_close_on_enter[constant_name_field;false]" ..
        "tooltip[constant_name_field;" .. FS("Any text, e.g. SEA_LEVEL") .. "]" ..
        "field[4.8,4.2;4.1,1;constant_value_field;" .. FS("Constant value (optional)") .. ";" ..
            tab_data_table[tab_type]["constant_value"] .. "]" ..
        "field_close_on_enter[constant_value_field;false]" ..
        "tooltip[constant_value_field;" .. FS("Any numeric value, e.g. 1") .. "]" ..
        "button[8.5,3.9;1.5,1;constant_add_btn;" .. FS("Add") .. "]" ..
        "tooltip[constant_add_btn;" .. FS("Any constant to the list above") .. "]"

    -- If any of the visible tabs specify buttons to be added here, then add them
    local count = 0
    local x = 0
    local y = 0
    local btn_len = 4.5
    local btn_hei = 0.8

    for _, this_tab_type in ipairs(tab_display_list) do

        if tab_defn_table[this_tab_type]["add_constant_label"] and
                tab_defn_table[this_tab_type]["add_constant_func"] then

            count = count + 1

            local btn_name = "add_constant_btn_" .. this_tab_type
            button_func_table[btn_name] = tab_defn_table[this_tab_type]["add_constant_func"]

            formspec = formspec ..
                "button[" .. (1 + (x * btn_len)) .. "," .. (7.3 + (y * btn_hei)) .. ";" ..
                    (btn_len + 0.05) .. "," .. (btn_hei - 0.1) .. ";" .. btn_name .. ";" ..
                    tab_defn_table[this_tab_type]["add_constant_label"] .. "]"

            x = x + 1
            if x > 1 then

                x = 0
                y = y + 1

                -- We have enough room for 4 rows (just about)
                if y > 3 then
                    break
                end

            end

        end

    end

    -- If any buttons were added, add an explanation
    if count > 0 then

        formspec = formspec ..
            "label[0,5;" .. FS("Add standard constants") .. "]" ..
            "textarea[0.5,5.5;9.5,2;;;" ..
                FS(
                    "These constants represent empty fields (i.e. optional values that you don't" ..
                    " need)."
                ) .. "\n\n" ..
                FS(
                    "You should add the constants if you want to edit the biome/decoration/ore" ..
                    " CSVs in a text editor. You can then use the constant buttons in the other" ..
                    " tabs to populate empty fields with these same constants."
                ) ..
                "]" ..
            "image[0,7.3;0.8,0.8;unilib_gui_insert.png]"

    end

    return formspec

end

local function get_biome_formspec_section(tab_type)

    -- N.B. There isn't enough room for the "original name" field; omitted it altogether
    local formspec =
        "label[1.2,0.2;" .. FS("Add biomes to remix \"@1\"", current_remix_name) .. "]" ..
        "field[0.3,4.2;3.4,1;biome_name_field;" .. FS("Biome name") .. ";" ..
            (tab_data_table[tab_type]["biome_name"] or "") .. "]" ..
        "field_close_on_enter[biome_name_field;false]" ..
        "tooltip[biome_name_field;" .. F("e.g. default_grassland") .. "]" ..
        "field[3.6,4.2;3.9,1;biome_descrip_field;" .. FS("Description") .. ";" ..
            (tab_data_table[tab_type]["biome_descrip"] or "") .. "]" ..
        "field_close_on_enter[biome_descrip_field;false]" ..
        "tooltip[biome_descrip_field;" .. F("e.g. Grassland biome (default)") .. "]" ..
        "image_button[7.1,4;0.8,0.8;unilib_gui_insert.png;biome_insert_btn;;;]" ..
        "tooltip[biome_insert_btn;" .. unilib.gui.insert_constants_msg .. "]" ..
        "image_button[7.8,4;0.8,0.8;unilib_gui_unsearch.png;biome_clear_btn;;;]" ..
        "tooltip[biome_clear_btn;" .. unilib.gui.empty_fields_msg .. "]" ..
        "button[8.5,3.9;1.5,1;biome_add_btn;" .. FS("Add") .. "]" ..
        "tooltip[biome_add_btn;" .. FS("Add biome to the list above") .. "]" ..
        "field[0.3,5.3;2.1,1;biome_max_field;" .. FS("Max height") .. ";" ..
            (tab_data_table[tab_type]["biome_max"] or "") .. "]" ..
        "field_close_on_enter[biome_max_field;false]" ..
        "tooltip[biome_max_field;" .. F("e.g. 31000") .. "]" ..
        "field[2.3,5.3;2.1,1;biome_min_field;" .. FS("Min height") .. ";" ..
            (tab_data_table[tab_type]["biome_min"] or "") .. "]" ..
        "field_close_on_enter[biome_min_field;false]" ..
        "tooltip[biome_min_field;" .. F("e.g. 6") .. "]" ..
        "field[4.3,5.3;2.1,1;biome_blend_field;" .. FS("Vertical blend") .. ";" ..
            (tab_data_table[tab_type]["biome_blend"] or "") .. "]" ..
        "field_close_on_enter[biome_blend_field;false]" ..
        "tooltip[biome_blend_field;" .. F("e.g. 2") .. "]" ..
        "field[6.3,5.3;2.1,1;biome_heat_field;" .. FS("Heat point") .. ";" ..
            (tab_data_table[tab_type]["biome_heat"] or "") .. "]" ..
        "field_close_on_enter[biome_heat_field;false]" ..
        "tooltip[biome_heat_field;" .. F("e.g. 50") .. "]" ..
        "field[8.3,5.3;2,1;biome_humidity_field;" .. FS("Humidity point") .. ";" ..
            (tab_data_table[tab_type]["biome_humidity"] or "") .. "]" ..
        "field_close_on_enter[biome_humidity_field;false]" ..
        "tooltip[biome_humidity_field;" .. F("e.g. 35") .. "]" ..
        "field[0.3,6.4;3.4,1;biome_dust_field;" .. FS("Dust node") .. ";" ..
            (tab_data_table[tab_type]["biome_dust"] or "") .. "]" ..
        "field_close_on_enter[biome_dust_field;false]" ..
        "tooltip[biome_dust_field;" .. F("e.g. unilib:snow_ordinary") .. "]" ..
        "field[3.6,6.4;3.4,1;biome_top_field;" .. FS("Top node and depth") .. ";" ..
            (tab_data_table[tab_type]["biome_top"] or "") .. "]" ..
        "field_close_on_enter[biome_top_field;false]" ..
        "tooltip[biome_top_field;" .. F("e.g. unilib:dirt_ordinary_with_turf 1") .. "]" ..
        "field[6.9,6.4;3.4,1;biome_fill_field;" .. FS("Fill node and depth") .. ";" ..
            (tab_data_table[tab_type]["biome_fill"] or "") .. "]" ..
        "field_close_on_enter[biome_fill_field;false]" ..
        "tooltip[biome_fill_field;" .. F("e.g. unilib:dirt_ordinary 2") .. "]" ..
        "field[0.3,7.5;3.4,1;biome_stone_field;" .. FS("Stone node") .. ";" ..
            (tab_data_table[tab_type]["biome_stone"] or "") .. "]" ..
        "field_close_on_enter[biome_stone_field;false]" ..
        "tooltip[biome_stone_field;" .. F("e.g. unilib:stone_travertine") .. "]" ..
        "field[3.6,7.5;3.4,1;biome_water_top_field;" .. FS("Top water node and depth") .. ";" ..
            (tab_data_table[tab_type]["biome_water_top"] or "") .. "]" ..
        "field_close_on_enter[biome_water_top_field;false]" ..
        "tooltip[biome_water_top_field;" .. F("e.g. unilib:liquid_water_dirty_source 1") .. "]" ..
        "field[6.9,7.5;3.4,1;biome_water_field;" .. FS("Water node") .. ";" ..
            (tab_data_table[tab_type]["biome_water"] or "") .. "]" ..
        "field_close_on_enter[biome_water_field;false]" ..
        "tooltip[biome_water_field;" .. F("e.g. unilib:liquid_water_ordinary_source") .. "]" ..
        "field[0.3,8.6;3.4,1;biome_river_field;" .. FS("River node") .. ";" ..
            (tab_data_table[tab_type]["biome_river"] or "") .. "]" ..
        "field_close_on_enter[biome_river_field;false]" ..
        "tooltip[biome_river_field;" .. F("e.g. unilib:liquid_water_river_source") .. "]" ..
        "field[3.6,8.6;3.4,1;biome_riverbed_field;" .. FS("Riverbed node and depth") .. ";" ..
            (tab_data_table[tab_type]["biome_riverbed"] or "") .. "]" ..
        "field_close_on_enter[biome_riverbed_field;false]" ..
        "tooltip[biome_riverbed_field;" .. F("unilib:sand_ordinary") .. "]" ..
        "field[6.9,8.6;3.4,1;biome_cave_liquid_field;" .. FS("Cave liquid node(s)") .. ";" ..
            (tab_data_table[tab_type]["biome_cave_liquid"] or "") .. "]" ..
        "field_close_on_enter[biome_cave_liquid_field;false]" ..
        "tooltip[biome_cave_liquid_field;" ..
            F("e.g. unilib:liquid_water_ordinary_source unilib:liquid_lava_ordinary_source") ..
            "]" ..
        "field[0.3,9.7;3.4,1;biome_dungeon_field;" .. FS("Dungeon node") .. ";" ..
            (tab_data_table[tab_type]["biome_dungeon"] or "") .. "]" ..
        "field_close_on_enter[biome_dungeon_field;false]" ..
        "tooltip[biome_dungeon_field;" .. F("e.g. unilib:stone_ordinary_cobble") .. "]" ..
        "field[3.6,9.7;3.4,1;biome_dungeon_alt_field;" .. FS("Alternate dungeon node") .. ";" ..
            (tab_data_table[tab_type]["biome_dungeon_alt"] or "") .. "]" ..
        "field_close_on_enter[biome_dungeon_alt_field;false]" ..
        "tooltip[biome_dungeon_alt_field;" .. F("e.g. unilib:stone_ordinary_cobble_mossy") .. "]" ..
        "field[6.9,9.7;3.4,1;biome_dungeon_stair_field;" .. FS("Dungeon stair node") .. ";" ..
            (tab_data_table[tab_type]["biome_dungeon_stair"] or "") .. "]" ..
        "field_close_on_enter[biome_dungeon_stair_field;false]" ..
        "tooltip[biome_dungeon_stair_field;" ..
            F("e.g. unilib:stone_ordinary_cobble_stair_simple") .. "]"

    return formspec

end

local function get_decoration_formspec_section(tab_type)

    local name_label = FS("Node name")
    local name_tooltip = F("e.g. unilib:grass_jungle")

    local deco_type = tab_data_table[tab_type]["deco_type"]
    if deco_type == 2 or deco_type == 3 then

        name_label = FS("Schematic file name")
        name_tooltip = F("e.g. unilib_tree_apple.mts")

    elseif deco_type == 4 then

        name_label = FS("Tree/schematic name")
        name_tooltip = F("Node or schematic name")

    end

    local formspec =
        "label[1.2,0.2;" .. FS("Add decorations to remix \"@1\"", current_remix_name) .. "]" ..
        "dropdown[0,4;3;deco_type_dbox;" .. FS("Simple") .. "," .. FS("Schematic") .. "," ..
            FS("Schematic (no rotate)") .. "," .. FS("Tree log") .. ";" ..
            tab_data_table[tab_type]["deco_type"] .. ";true]" ..
        "tooltip[deco_type_dbox;" .. FS("Decoration type") .. "]" ..
        "field[3.2,4.2;4.3,1;deco_name_field;" .. name_label .. ";" ..
            (tab_data_table[tab_type]["deco_name"] or "") .. "]" ..
        "field_close_on_enter[deco_name_field;false]" ..
        "tooltip[deco_name_field;" .. name_tooltip .. "]" ..
        "image_button[7.1,4;0.8,0.8;unilib_gui_insert.png;deco_insert_btn;;;]" ..
        "tooltip[deco_insert_btn;" .. unilib.gui.insert_constants_msg .. "]" ..
        "image_button[7.8,4;0.8,0.8;unilib_gui_unsearch.png;deco_clear_btn;;;]" ..
        "tooltip[deco_clear_btn;" .. unilib.gui.empty_fields_msg .. "]" ..
        "button[8.5,3.9;1.5,1;deco_add_btn;" .. FS("Add") .. "]" ..
        "tooltip[deco_add_btn;" .. FS("Add decoration to the list above") .. "]" ..
        "field[0.3,5.3;2,1;deco_max_field;" .. FS("Max height") .. ";" ..
            (tab_data_table[tab_type]["deco_max"] or "") .. "]" ..
        "field_close_on_enter[deco_max_field;false]" ..
        "tooltip[deco_max_field;" .. F("e.g. 10") .. "]" ..
        "field[2.2,5.3;2,1;deco_min_field;" .. FS("Min height") .. ";" ..
            (tab_data_table[tab_type]["deco_min"] or "") .. "]" ..
        "field_close_on_enter[deco_min_field;false]" ..
        "tooltip[deco_min_field;" .. F("e.g. 5") .. "]" ..
        "field[0.3,6.4;10,1;deco_biomes_field;" .. FS("Spawn in biomes") .. ";" ..
            (tab_data_table[tab_type]["deco_biomes"] or "") .. "]" ..
        "field_close_on_enter[deco_biomes_field;false]" ..
        "tooltip[deco_biomes_field;" .. F("e.g. default_grassland default_tundra") .. "]" ..
        "field[0.3,7.5;10,1;deco_place_on_field;" .. FS("Place on nodes") .. ";" ..
            (tab_data_table[tab_type]["deco_place_on"] or "") .. "]" ..
        "field_close_on_enter[deco_place_on_field;false]" ..
        "tooltip[deco_place_on_field;" ..
            F("e.g. unilib:dirt_ordinary unilib:sand_ordinary") .. "]" ..
        "field[0.3,8.6;7.5,1;deco_spawn_by_field;" .. FS("Spawn by nodes") .. ";" ..
            (tab_data_table[tab_type]["deco_spawn_by"] or "") .. "]" ..
        "field_close_on_enter[deco_spawn_by_field;false]" ..
        "tooltip[deco_spawn_by_field;" ..
            F("e.g unilib:tree_apple_trunk unilib:tree_acacia_trunk") .. "]" ..
        "field[7.7,8.6;2.5,1;deco_num_spawn_field;" .. FS("Spawn by number") .. ";" ..
            (tab_data_table[tab_type]["deco_num_spawn"] or "") .. "]" ..
        "field_close_on_enter[deco_num_spawn_field;false]" ..
        "tooltip[deco_num_spawn_field;" .. F("e.g. 1") .. "]" ..
        "field[0.3,9.7;2,1;deco_fill_ratio_field;" .. FS("Fill ratio") .. ";" ..
            (tab_data_table[tab_type]["deco_fill_ratio"] or "") .. "]" ..
        "field_close_on_enter[deco_fill_ratio_field;false]" ..
        "tooltip[deco_fill_ratio_field;" .. F("e.g. 0.02") .. "]" ..
        "field[2.2,9.7;2.3,1;deco_rnd_height_field;" .. FS("Max random height") .. ";" ..
            (tab_data_table[tab_type]["deco_rnd_height"] or "") .. "]" ..
        "field_close_on_enter[deco_rnd_height_field;false]" ..
        "tooltip[deco_rnd_height_field;" .. F("e.g. 0") .. "]" ..
        "field[4.4,9.7;4,1;deco_flags_field;" .. FS("Flags") .. ";" ..
            (tab_data_table[tab_type]["deco_flags"] or "") .. "]" ..
        "field_close_on_enter[deco_flags_field;false]" ..
        "tooltip[deco_flags_field;" .. F("e.g. place_center_x place_center_z") .. "]" ..
        "field[8.3,9.7;2,1;deco_sidelen_field;" .. FS("Side length") .. ";" ..
            (tab_data_table[tab_type]["deco_sidelen"] or "") .. "]" ..
        "field_close_on_enter[deco_sidelen_field;false]" ..
        "tooltip[deco_sidelen_field;" .. F("e.g. 4") .. "]"

    return formspec

end

local function get_ore_formspec_section(tab_type)

    local formspec =
        "label[1.2,0.2;" ..
            FS("Add ore distributions to remix \"@1\"", current_remix_name) .. "]" ..
        "dropdown[0,4;2;ore_type_dbox;" .. FS("Blob") .. "," .. FS("Puff") .. "," ..
            FS("Scatter") .. "," .. FS("Sheet") .. "," .. FS("Stratum") .. "," .. FS("Vein") ..
            ";" .. tab_data_table[tab_type]["ore_type"] .. ";true]" ..
        "tooltip[ore_type_dbox;" .. FS("Ore type") .. "]" ..
        "field[2.2,4.2;5.3,1;ore_name_field;" .. FS("Ore") .. ";" ..
            (tab_data_table[tab_type]["ore_name"] or "") .. "]" ..
        "field_close_on_enter[ore_name_field;false]" ..
        "tooltip[ore_name_field;" .. F("e.g. unilib:stone_ordinary_with_iron") .. "]" ..
        "image_button[7.1,4;0.8,0.8;unilib_gui_insert.png;ore_insert_btn;;;]" ..
        "tooltip[ore_insert_btn;" .. unilib.gui.insert_constants_msg .. "]" ..
        "image_button[7.8,4;0.8,0.8;unilib_gui_unsearch.png;ore_clear_btn;;;]" ..
        "tooltip[ore_clear_btn;" .. unilib.gui.empty_fields_msg .. "]" ..
        "button[8.5,3.9;1.5,1;ore_add_btn;" .. FS("Add") .. "]" ..
        "tooltip[ore_add_btn;" .. FS("Add ore to the list above") .. "]" ..
        "field[0.3,5.3;3.5,1;ore_wherein_field;" .. FS("Wherein") .. ";" ..
            (tab_data_table[tab_type]["ore_wherein"] or "") .. "]" ..
        "field_close_on_enter[ore_wherein_field;false]" ..
        "tooltip[ore_wherein_field;" .. F("e.g. unilib:stone_ordinary") .. "]" ..
        "field[3.7,5.3;2.7,1;ore_biomes_field;" .. FS("Biomes") .. ";" ..
            (tab_data_table[tab_type]["ore_biomes"] or "") .. "]" ..
        "field_close_on_enter[ore_biomes_field;false]" ..
        "tooltip[ore_biomes_field;" .. F("e.g. default_grassland_under") .. "]" ..
        "field[6.3,5.3;1.4,1;ore_scarcity_field;" .. FS("Cl. scarcity") .. ";" ..
            (tab_data_table[tab_type]["ore_scarcity"] or "") .. "]" ..
        "field_close_on_enter[ore_scarcity_field;false]" ..
        "tooltip[ore_scarcity_field;" .. F("Cluster scarcity, e.g. 343 (i.e. 7*7*7)") .. "]" ..
        "field[7.6,5.3;1.4,1;ore_num_field;" .. FS("No. ores") .. ";" ..
            (tab_data_table[tab_type]["ore_num"] or "") .. "]" ..
        "field_close_on_enter[ore_num_field;false]" ..
        "tooltip[ore_num_field;" .. F("e.g. 12") .. "]" ..
        "field[8.9,5.3;1.4,1;ore_size_field;" .. FS("Cl. size") .. ";" ..
            (tab_data_table[tab_type]["ore_size"] or "") .. "]" ..
        "field_close_on_enter[ore_size_field;false]" ..
        "tooltip[ore_size_field;" .. F("Cluster size, e.g. 3") .. "]" ..
        "field[0.3,6.4;1.5,1;ore_max_field;" .. FS("Max height") .. ";" ..
            (tab_data_table[tab_type]["ore_max"] or "") .. "]" ..
        "field_close_on_enter[ore_max_field;false]" ..
        "tooltip[ore_max_field;" .. F("e.g. 31000") .. "]" ..
        "field[1.7,6.4;1.5,1;ore_min_field;" .. FS("Min height") .. ";" ..
            (tab_data_table[tab_type]["ore_min"] or "") .. "]" ..
        "field_close_on_enter[ore_min_field;false]" ..
        "tooltip[ore_min_field;" .. F("e.g. -31000") .. "]" ..
        "field[3.1,6.4;3.4,1;ore_flags_field;" .. FS("Flags") .. ";" ..
            (tab_data_table[tab_type]["ore_flags"] or "") .. "]" ..
        "field_close_on_enter[ore_flags_field;false]" ..
        "tooltip[ore_flags_field;" .. F("e.g. puff_cliffs") .. "]" ..
        "field[6.4,6.4;2,1;ore_threshold_field;" .. FS("Noise threshold") .. ";" ..
            (tab_data_table[tab_type]["ore_threshold"] or "") .. "]" ..
        "field_close_on_enter[ore_threshold_field;false]" ..
        "tooltip[ore_threshold_field;" .. F("e.g. 0") .. "]" ..
        "field[8.3,6.4;2,1;ore_param2_field;" .. FS("param2 value") .. ";" ..
            (tab_data_table[tab_type]["ore_param2"] or "") .. "]" ..
        "field_close_on_enter[ore_param2_field;false]" ..
        "tooltip[ore_param2_field;" .. F("e.g. 0") .. "]" ..
        "field[0.3,7.5;1.5,1;ore_np_offset_field;" .. FS("Perlin offset") .. ";" ..
            (tab_data_table[tab_type]["ore_np_offset"] or "") .. "]" ..
        "field_close_on_enter[ore_np_offset_field;false]" ..
        "tooltip[ore_np_offset_field;" .. F("e.g. 0") .. "]" ..
        "field[1.7,7.5;1.5,1;ore_np_scale_field;" .. FS("Scale") .. ";" ..
            (tab_data_table[tab_type]["ore_np_scale"] or "") .. "]" ..
        "field_close_on_enter[ore_np_scale_field;false]" ..
        "tooltip[ore_np_scale_field;" .. F("e.g. 1") .. "]" ..
        "field[3.1,7.5;3,1;ore_np_spread_field;" .. FS("Spread") .. ";" ..
            (tab_data_table[tab_type]["ore_np_spread"] or "") .. "]" ..
        "field_close_on_enter[ore_np_spread_field;false]" ..
        "tooltip[ore_np_spread_field;" .. F("e.g. x = 5, y = 5, z = 5") .. "]" ..
        "field[6,7.5;1.5,1;ore_np_seed_field;" .. FS("Seed") .. ";" ..
            (tab_data_table[tab_type]["ore_np_seed"] or "") .. "]" ..
        "field_close_on_enter[ore_np_seed_field;false]" ..
        "tooltip[ore_np_seed_field;" .. F("23") .. "]" ..
        "field[7.4,7.5;1.5,1;ore_np_octaves_field;" .. FS("Octaves") .. ";" ..
            (tab_data_table[tab_type]["ore_np_octaves"] or "") .. "]" ..
        "field_close_on_enter[ore_np_octaves_field;false]" ..
        "tooltip[ore_np_octaves_field;" .. F("3") .. "]" ..
        "field[8.8,7.5;1.5,1;ore_np_persist_field;" .. FS("Persistence") .. ";" ..
            (tab_data_table[tab_type]["ore_np_persist"] or "") .. "]" ..
        "field_close_on_enter[ore_np_persist_field;false]" ..
        "tooltip[ore_np_persist_field;" .. F("0.7") .. "]"

    if tab_type == "ore_puff" then

        formspec = formspec ..
            "field[0.3,8.6;1.5,1;ore_nppt_offset_field;" .. FS("Top offset") .. ";" ..
                (tab_data_table[tab_type]["ore_nppt_offset"] or "") .. "]" ..
            "field_close_on_enter[ore_nppt_offset_field;false]" ..
            "tooltip[ore_nppt_offset_field;" .. F("e.g. 4") .. "]" ..
            "field[1.7,8.6;1.5,1;ore_nppt_scale_field;" .. FS("Scale") .. ";" ..
                (tab_data_table[tab_type]["ore_nppt_scale"] or "") .. "]" ..
            "field_close_on_enter[ore_nppt_scale_field;false]" ..
            "tooltip[ore_nppt_scale_field;" .. F("e.g. 2") .. "]" ..
            "field[3.1,8.6;3,1;ore_nppt_spread_field;" .. FS("Spread") .. ";" ..
                (tab_data_table[tab_type]["ore_nppt_spread"] or "") .. "]" ..
            "field_close_on_enter[ore_nppt_spread_field;false]" ..
            "tooltip[ore_nppt_spread_field;" .. F("e.g. x = 100, y = 100, z = 100") .. "]" ..
            "field[6,8.6;1.5,1;ore_nppt_seed_field;" .. FS("Seed") .. ";" ..
                (tab_data_table[tab_type]["ore_nppt_seed"] or "") .. "]" ..
            "field_close_on_enter[ore_nppt_seed_field;false]" ..
            "tooltip[ore_nppt_seed_field;" .. F("e.g. 47") .. "]" ..
            "field[7.4,8.6;1.5,1;ore_nppt_octaves_field;" .. FS("Octaves") .. ";" ..
                (tab_data_table[tab_type]["ore_nppt_octaves"] or "") .. "]" ..
            "field_close_on_enter[ore_nppt_octaves_field;false]" ..
            "tooltip[ore_nppt_octaves_field;" .. F("e.g. 3") .. "]" ..
            "field[8.8,8.6;1.5,1;ore_nppt_persist_field;" .. FS("Persistence") .. ";" ..
                (tab_data_table[tab_type]["ore_nppt_persist"] or "") .. "]" ..
            "field_close_on_enter[ore_nppt_persist_field;false]" ..
            "tooltip[ore_nppt_persist_field;" .. F("e.g. 0.7") .. "]" ..
            "field[0.3,9.7;1.5,1;ore_nppb_offset_field;" .. FS("Btm offset") .. ";" ..
                (tab_data_table[tab_type]["ore_nppb_offset"] or "") .. "]" ..
            "field_close_on_enter[ore_nppb_offset_field;false]" ..
            "tooltip[ore_nppb_offset_field;" .. F("e.g. 4") .. "]" ..
            "field[1.7,9.7;1.5,1;ore_nppb_scale_field;" .. FS("Scale") .. ";" ..
                (tab_data_table[tab_type]["ore_nppb_scale"] or "") .. "]" ..
            "field_close_on_enter[ore_nppb_scale_field;false]" ..
            "tooltip[ore_nppb_scale_field;" .. F("e.g. 2") .. "]" ..
            "field[3.1,9.7;3,1;ore_nppb_spread_field;" .. FS("Spread") .. ";" ..
                (tab_data_table[tab_type]["ore_nppb_spread"] or "") .. "]" ..
            "field_close_on_enter[ore_nppb_spread_field;false]" ..
            "tooltip[ore_nppb_spread_field;" .. F("e.g. x = 100, y = 100, z = 100") .. "]" ..
            "field[6,9.7;1.5,1;ore_nppb_seed_field;" .. FS("Seed") .. ";" ..
                (tab_data_table[tab_type]["ore_nppb_seed"] or "") .. "]" ..
            "field_close_on_enter[ore_nppb_seed_field;false]" ..
            "tooltip[ore_nppb_seed_field;" .. F("e.g. 11") .. "]" ..
            "field[7.4,9.7;1.5,1;ore_nppb_octaves_field;" .. FS("Octaves") .. ";" ..
                (tab_data_table[tab_type]["ore_nppb_octaves"] or "") .. "]" ..
            "field_close_on_enter[ore_nppb_octaves_field;false]" ..
            "tooltip[ore_nppb_octaves_field;" .. F("e.g. 3") .. "]" ..
            "field[8.8,9.7;1.5,1;ore_nppb_persist_field;" .. FS("Persistence") .. ";" ..
                (tab_data_table[tab_type]["ore_nppb_persist"] or "") .. "]" ..
            "field_close_on_enter[ore_nppb_persist_field;false]" ..
            "tooltip[ore_nppb_persist_field;" .. F("e.g. 0.7") .. "]"

    elseif tab_type == "ore_sheet" then

        formspec = formspec ..
            "field[0.3,8.6;3.4,1;ore_column_max_field;" .. FS("Max column height") .. ";" ..
                (tab_data_table[tab_type]["ore_column_max"] or "") .. "]" ..
            "field_close_on_enter[ore_column_max_field;false]" ..
            "tooltip[ore_column_max_field;" .. F("e.g. 16") .. "]" ..
            "field[3.6,8.6;3.4,1;ore_column_min_field;" .. FS("Min column height") .. ";" ..
                (tab_data_table[tab_type]["ore_column_min"] or "") .. "]" ..
            "field_close_on_enter[ore_column_min_field;false]" ..
            "tooltip[ore_column_min_field;" .. F("e.g. 1") .. "]" ..
            "field[6.9,8.6;3.4,1;ore_column_mid_field;" .. FS("Column midpoint factor") .. ";" ..
                (tab_data_table[tab_type]["ore_column_mid"] or "") .. "]" ..
            "field_close_on_enter[ore_column_mid_field;false]" ..
            "tooltip[ore_column_mid_field;" .. F("e.g. 0.5") .. "]"

    elseif tab_type == "ore_stratum" then

        formspec = formspec ..
            "field[0.3,8.6;1.5,1;ore_npst_offset_field;" .. FS("Str. offset") .. ";" ..
                (tab_data_table[tab_type]["ore_npst_offset"] or "") .. "]" ..
            "field_close_on_enter[ore_npst_offset_field;false]" ..
            "tooltip[ore_npst_offset_field;" .. F("e.g. 8") .. "]" ..
            "field[1.7,8.6;1.5,1;ore_npst_scale_field;" .. FS("Scale") .. ";" ..
                (tab_data_table[tab_type]["ore_npst_scale"] or "") .. "]" ..
            "field_close_on_enter[ore_npst_scale_field;false]" ..
            "tooltip[ore_npst_scale_field;" .. F("e.g. 4") .. "]" ..
            "field[3.1,8.6;3,1;ore_npst_spread_field;" .. FS("Spread") .. ";" ..
                (tab_data_table[tab_type]["ore_npst_spread"] or "") .. "]" ..
            "field_close_on_enter[ore_npst_spread_field;false]" ..
            "tooltip[ore_npst_spread_field;" .. F("e.g. x = 100, y = 100, z = 100") .. "]" ..
            "field[6,8.6;1.5,1;ore_npst_seed_field;" .. FS("Seed") .. ";" ..
                (tab_data_table[tab_type]["ore_npst_seed"] or "") .. "]" ..
            "field_close_on_enter[ore_npst_seed_field;false]" ..
            "tooltip[ore_npst_seed_field;" .. F("e.g. 17") .. "]" ..
            "field[7.4,8.6;1.5,1;ore_npst_octaves_field;" .. FS("Octaves") .. ";" ..
                (tab_data_table[tab_type]["ore_npst_octaves"] or "") .. "]" ..
            "field_close_on_enter[ore_npst_octaves_field;false]" ..
            "tooltip[ore_npst_octaves_field;" .. F("e.g. 3") .. "]" ..
            "field[8.8,8.6;1.5,1;ore_npst_persist_field;" .. FS("Persistence") .. ";" ..
                (tab_data_table[tab_type]["ore_npst_persist"] or "") .. "]" ..
            "field_close_on_enter[ore_npst_persist_field;false]" ..
            "tooltip[ore_npst_persist_field;" .. F("e.g. 0.7") .. "]" ..
            "field[0.3,9.7;2.9,1;ore_stratum_thick_field;" .. FS("Stratum thickness") .. ";" ..
                (tab_data_table[tab_type]["ore_stratum_thick"] or "") .. "]" ..
            "field_close_on_enter[ore_stratum_thick_field;false]" ..
            "tooltip[ore_stratum_thick_field;" .. F("e.g. 8") .. "]"

    elseif tab_type == "ore_vein" then

        formspec = formspec ..
            "field[0.3,8.6;2.9,1;ore_rnd_factor_field;" .. FS("Random factor") .. ";" ..
                (tab_data_table[tab_type]["ore_rnd_factor"] or "") .. "]" ..
            "field_close_on_enter[ore_rnd_factor_field;false]" ..
            "tooltip[ore_rnd_factor_field;" .. F("e.g. 1.0") .. "]"

    end

    return formspec

end

local function get_edit_formspec(pname)

    local tab_type = tab_display_list[current_tab]

    -- Formspec widgets common to all tabs
    local formspec =
        "size[10,10;]" ..
        "tabheader[0,0;tabs;" .. get_tab_labels() .. ";" .. current_tab .. ";false;false]" ..
        "image[0,0;1,1;unilib_logo_unilib.png]" ..
        "button[7.1,0;1.5,1;main_reset_btn;" .. FS("Reload") .. "]" ..
        "tooltip[main_reset_btn;" .. FS("Reload this file") .. "]" ..
        "button[8.5,0;1.5,1;main_save_btn;" .. FS("Save") .. "]" ..
        "tooltip[main_save_btn;" .. FS("Save this file to the mod storage folder") .. "]"

    if tab_defn_table[tab_type]["warning_call_func"] and (
        tab_defn_table[tab_type]["warning_check_func"] == nil or
        tab_defn_table[tab_type]["warning_check_func"](tab_type) == true
    ) then

        formspec = formspec ..
            "image_button_exit[5.65,0.1;0.8,0.8;unilib_gui_warning.png;main_warning_btn;;;]"

        if tab_defn_table[tab_type]["warning_tooltip"] then

            formspec = formspec ..
                "tooltip[main_warning_btn;" .. tab_defn_table[tab_type]["warning_tooltip"] .. "]"

        end

    end

    if tab_defn_table[tab_type]["convert_func"] then

        formspec = formspec ..
            "image_button[6.4,0.1;0.8,0.8;unilib_gui_convert.png;main_split_btn;;;]" ..
            "tooltip[main_split_btn;" .. unilib.gui.convert_fields_msg .. "]"

    end

    if not split_notepad_flag then

        formspec = formspec ..
            "textarea[0.3,1.1;10,2.9;main_notepad;;" ..
                (F(tab_data_table[tab_type]["content"]) or "") .. "]"

    else

        -- (Split the nodepad into two areas, the lower one for converting CSV text into separate
        --      fields)
        formspec = formspec ..
            "textarea[0.3,1.1;10,1.8;main_notepad;;" ..
                (F(tab_data_table[tab_type]["content"]) or "") .. "]" ..
            "field[0.3,3;8.6,1;main_convert_field;;]" ..
            "field_close_on_enter[main_convert_field;false]" ..
            "tooltip[main_convert_field;" .. FS("Copy and paste a line from above") .. "]" ..
            "button[8.5,2.7;1.5,1;main_convert_btn;" .. FS("Convert") .. "]" ..
            "tooltip[main_convert_btn;" .. FS("Convert into separate fields below") .. "]"

    end

    formspec = formspec ..
        "tooltip[main_notepad;" ..
            FS("Editing file: @1", tab_defn_table[tab_type]["file"]) .. "]" ..
        current_invisible_text

    -- Formspec widgets unique to each tab
    if tab_defn_table[tab_type]["formspec_func"] then
        formspec = formspec .. tab_defn_table[tab_type]["formspec_func"](tab_type)
    end

    -- unilib v1.2.0 workaround for an apparent bug in Minetest 5.11
    -- When the reset button is clicked, Minetest is asked to re-display the formspec, but it just
    --      re-uses the old one (which it thinks is the same as the new one)
    -- That means that any changes the user has made to the textareas and fields are not reset, as
    --      intended
    -- Workaround is to make sure that two consecutive formspec strings are not the same
    if current_invisible_text == "" then
        current_invisible_text = " "
    else
        current_invisible_text = ""
    end

    return formspec

end

local function get_confirm_formspec(pname)

    return "size[8,3;]" ..
        "image[0,0;1,1;unilib_logo_unilib.png]" ..
        "label[1.2,0.2;" .. FS("Confirm reload file") .. "]" ..
        "label[0.35,1.25;" .. FS("Are you sure you want to reload this file?") .. "]" ..
        "button[1,2;3,1;yes_btn;" .. FS("Yes") .. "]" ..
        "button[4,2;3,1;no_btn;" .. FS("No") .. "]"

end

---------------------------------------------------------------------------------------------------
-- Local functions (formspec data storage)
---------------------------------------------------------------------------------------------------

local function store_biome_fields(tab_type, fields)

    tab_data_table[tab_type]["biome_descrip"] =
            unilib.utils.strip_whitespace(fields.biome_descrip_field)
    tab_data_table[tab_type]["biome_max"] = unilib.utils.strip_whitespace(fields.biome_max_field)
    tab_data_table[tab_type]["biome_min"] = unilib.utils.strip_whitespace(fields.biome_min_field)
    tab_data_table[tab_type]["biome_blend"] =
            unilib.utils.strip_whitespace(fields.biome_blend_field)
    tab_data_table[tab_type]["biome_heat"] = unilib.utils.strip_whitespace(fields.biome_heat_field)
    tab_data_table[tab_type]["biome_humidity"] =
            unilib.utils.strip_whitespace(fields.biome_humidity_field)
    tab_data_table[tab_type]["biome_dust"] = unilib.utils.strip_whitespace(fields.biome_dust_field)
    tab_data_table[tab_type]["biome_top"] = unilib.utils.strip_whitespace(fields.biome_top_field)
    tab_data_table[tab_type]["biome_fill"] = unilib.utils.strip_whitespace(fields.biome_fill_field)
    tab_data_table[tab_type]["biome_stone"] =
            unilib.utils.strip_whitespace(fields.biome_stone_field)
    tab_data_table[tab_type]["biome_water_top"] =
            unilib.utils.strip_whitespace(fields.biome_water_top_field)
    tab_data_table[tab_type]["biome_water"] =
            unilib.utils.strip_whitespace(fields.biome_water_field)
    tab_data_table[tab_type]["biome_river"] =
            unilib.utils.strip_whitespace(fields.biome_river_field)
    tab_data_table[tab_type]["biome_riverbed"] =
            unilib.utils.strip_whitespace(fields.biome_riverbed_field)
    tab_data_table[tab_type]["biome_cave_liquid"] =
            unilib.utils.strip_whitespace(fields.biome_cave_liquid_field)
    tab_data_table[tab_type]["biome_dungeon"] =
            unilib.utils.strip_whitespace(fields.biome_dungeon_field)
    tab_data_table[tab_type]["biome_dungeon_alt"] =
            unilib.utils.strip_whitespace(fields.biome_dungeon_alt_field)
    tab_data_table[tab_type]["biome_dungeon_stair"] =
            unilib.utils.strip_whitespace(fields.biome_dungeon_stair_field)

end

local function store_decoration_fields(tab_type, fields)

    tab_data_table[tab_type]["deco_type"] =
            tonumber(unilib.utils.strip_whitespace(fields.deco_type_dbox))
    tab_data_table[tab_type]["deco_max"] = unilib.utils.strip_whitespace(fields.deco_max_field)
    tab_data_table[tab_type]["deco_min"] = unilib.utils.strip_whitespace(fields.deco_min_field)
    tab_data_table[tab_type]["deco_biomes"] =
            unilib.utils.strip_whitespace(fields.deco_biomes_field)
    tab_data_table[tab_type]["deco_place_on"] =
            unilib.utils.strip_whitespace(fields.deco_place_on_field)
    tab_data_table[tab_type]["deco_spawn_by"] =
            unilib.utils.strip_whitespace(fields.deco_spawn_by_field)
    tab_data_table[tab_type]["deco_num_spawn"] =
            unilib.utils.strip_whitespace(fields.deco_num_spawn_field)
    tab_data_table[tab_type]["deco_fill_ratio"] =
            unilib.utils.strip_whitespace(fields.deco_fill_ratio_field)
    tab_data_table[tab_type]["deco_rnd_height"] =
            unilib.utils.strip_whitespace(fields.deco_rnd_height_field)
    tab_data_table[tab_type]["deco_flags"] = unilib.utils.strip_whitespace(fields.deco_flags_field)
    tab_data_table[tab_type]["deco_sidelen"] =
            unilib.utils.strip_whitespace(fields.deco_sidelen_field)

end

local function store_ore_fields(tab_type, fields)

    tab_data_table[tab_type]["ore_name"] = unilib.utils.strip_whitespace(fields.ore_name_field)
    tab_data_table[tab_type]["ore_wherein"] =
            unilib.utils.strip_whitespace(fields.ore_wherein_field)
    tab_data_table[tab_type]["ore_biomes"] = unilib.utils.strip_whitespace(fields.ore_biomes_field)
    tab_data_table[tab_type]["ore_scarcity"] =
            unilib.utils.strip_whitespace(fields.ore_scarcity_field)
    tab_data_table[tab_type]["ore_num"] = unilib.utils.strip_whitespace(fields.ore_num_field)
    tab_data_table[tab_type]["ore_size"] = unilib.utils.strip_whitespace(fields.ore_size_field)
    tab_data_table[tab_type]["ore_max"] = unilib.utils.strip_whitespace(fields.ore_max_field)
    tab_data_table[tab_type]["ore_min"] = unilib.utils.strip_whitespace(fields.ore_min_field)
    tab_data_table[tab_type]["ore_flags"] = unilib.utils.strip_whitespace(fields.ore_flags_field)
    tab_data_table[tab_type]["ore_threshold"] =
            unilib.utils.strip_whitespace(fields.ore_threshold_field)
    tab_data_table[tab_type]["ore_param2"] = unilib.utils.strip_whitespace(fields.ore_param2_field)
    tab_data_table[tab_type]["ore_np_offset"] =
            unilib.utils.strip_whitespace(fields.ore_np_offset_field)
    tab_data_table[tab_type]["ore_np_scale"] =
            unilib.utils.strip_whitespace(fields.ore_np_scale_field)
    tab_data_table[tab_type]["ore_np_spread"] =
            unilib.utils.strip_whitespace(fields.ore_np_spread_field)
    tab_data_table[tab_type]["ore_np_seed"] =
            unilib.utils.strip_whitespace(fields.ore_np_seed_field)
    tab_data_table[tab_type]["ore_np_octaves"] =
            unilib.utils.strip_whitespace(fields.ore_np_octaves_field)
    tab_data_table[tab_type]["ore_np_persist"] =
            unilib.utils.strip_whitespace(fields.ore_np_persist_field)

    if tab_type == "ore_puff" then

        tab_data_table[tab_type]["ore_nppt_offset"] =
                unilib.utils.strip_whitespace(fields.ore_nppt_offset_field)
        tab_data_table[tab_type]["ore_nppt_scale"] =
                unilib.utils.strip_whitespace(fields.ore_nppt_scale_field)
        tab_data_table[tab_type]["ore_nppt_spread"] =
                unilib.utils.strip_whitespace(fields.ore_nppt_spread_field)
        tab_data_table[tab_type]["ore_nppt_seed"] =
                unilib.utils.strip_whitespace(fields.ore_nppt_seed_field)
        tab_data_table[tab_type]["ore_nppt_octaves"] =
                unilib.utils.strip_whitespace(fields.ore_nppt_octaves_field)
        tab_data_table[tab_type]["ore_nppt_persist"] =
                unilib.utils.strip_whitespace(fields.ore_nppt_persist_field)
        tab_data_table[tab_type]["ore_nppb_offset"] =
                unilib.utils.strip_whitespace(fields.ore_nppb_offset_field)
        tab_data_table[tab_type]["ore_nppb_scale"] =
                unilib.utils.strip_whitespace(fields.ore_nppb_scale_field)
        tab_data_table[tab_type]["ore_nppb_spread"] =
                unilib.utils.strip_whitespace(fields.ore_nppb_spread_field)
        tab_data_table[tab_type]["ore_nppb_seed"] =
                unilib.utils.strip_whitespace(fields.ore_nppb_seed_field)
        tab_data_table[tab_type]["ore_nppb_octaves"] =
                unilib.utils.strip_whitespace(fields.ore_nppb_octaves_field)
        tab_data_table[tab_type]["ore_nppb_persist"] =
                unilib.utils.strip_whitespace(fields.ore_nppb_persist_field)

    elseif tab_type == "ore_sheet" then

        tab_data_table[tab_type]["ore_column_max"] =
                unilib.utils.strip_whitespace(fields.ore_column_max_field)
        tab_data_table[tab_type]["ore_column_min"] =
                unilib.utils.strip_whitespace(fields.ore_column_min_field)
        tab_data_table[tab_type]["ore_column_mid"] =
                unilib.utils.strip_whitespace(fields.ore_column_mid_field)

    elseif tab_type == "ore_stratum" then

        tab_data_table[tab_type]["ore_npst_offset"] =
                unilib.utils.strip_whitespace(fields.ore_npst_offset_field)
        tab_data_table[tab_type]["ore_npst_scale"] =
                unilib.utils.strip_whitespace(fields.ore_npst_scale_field)
        tab_data_table[tab_type]["ore_npst_spread"] =
                unilib.utils.strip_whitespace(fields.ore_npst_spread_field)
        tab_data_table[tab_type]["ore_npst_seed"] =
                unilib.utils.strip_whitespace(fields.ore_npst_seed_field)
        tab_data_table[tab_type]["ore_npst_octaves"] =
                unilib.utils.strip_whitespace(fields.ore_npst_octaves_field)
        tab_data_table[tab_type]["ore_npst_persist"] =
                unilib.utils.strip_whitespace(fields.ore_npst_persist_field)
        tab_data_table[tab_type]["ore_stratum_thick"] =
                unilib.utils.strip_whitespace(fields.ore_stratum_thick_field)

    elseif tab_type == "ore_vein" then

        tab_data_table[tab_type]["ore_rnd_factor"] =
                unilib.utils.strip_whitespace(fields.ore_rnd_factor_field)

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (formspec "add constant" buttons)
---------------------------------------------------------------------------------------------------

local function add_biome_constants(tab_type, fields)

    unilib.gui.update_notepad_in_edit_formspec(
        fields.main_notepad,
        tab_defn_table["biome"]["constant_table"]["biome_descrip"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_dust"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_top"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_fill"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_stone"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_water_top"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_water"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_river"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_riverbed"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_cave_liquid"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_dungeon"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_dungeon_alt"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_dungeon_stair"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_max"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_min"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_blend"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_heat"] .. "|\n" ..
            tab_defn_table["biome"]["constant_table"]["biome_humidity"] .. "|"
    )

end

local function add_decoration_constants(tab_type, fields)

    unilib.gui.update_notepad_in_edit_formspec(
        fields.main_notepad,
        tab_defn_table["decoration"]["constant_table"]["deco_max"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_min"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_biomes"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_place_on"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_spawn_by"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_num_spawn"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_fill_ratio"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_rnd_height"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_flags"] .. "|\n" ..
            tab_defn_table["decoration"]["constant_table"]["deco_sidelen"] .. "|"
    )

end

local function add_ore_constants(tab_type, fields)

    unilib.gui.update_notepad_in_edit_formspec(
        fields.main_notepad,
        tab_defn_table["ore_blob"]["constant_table"]["ore_param2"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_wherein"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_scarcity"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_num"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_size"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_max"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_min"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_flags"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_threshold"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_np_offset"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_np_scale"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_np_spread"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_np_seed"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_np_octaves"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_np_persist"] .. "|\n" ..
            tab_defn_table["ore_blob"]["constant_table"]["ore_biomes"] .. "|\n" ..

            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppt_offset"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppt_scale"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppt_spread"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppt_seed"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppt_octaves"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppt_persist"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppb_offset"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppb_scale"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppb_spread"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppb_seed"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppb_octaves"] .. "|\n" ..
            tab_defn_table["ore_puff"]["extra_constant_table"]["ore_nppb_persist"] .. "|\n" ..

            tab_defn_table["ore_sheet"]["extra_constant_table"]["ore_column_max"] .. "|\n" ..
            tab_defn_table["ore_sheet"]["extra_constant_table"]["ore_column_min"] .. "|\n" ..
            tab_defn_table["ore_sheet"]["extra_constant_table"]["ore_column_mid"] .. "|\n" ..

            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_npst_offset"] .. "|\n" ..
            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_npst_scale"] .. "|\n" ..
            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_npst_spread"] .. "|\n" ..
            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_npst_seed"] .. "|\n" ..
            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_npst_octaves"] .. "|\n" ..
            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_npst_persist"] .. "|\n" ..
            tab_defn_table["ore_stratum"]["extra_constant_table"]["ore_stratum_thick"] .. "|\n" ..

            tab_defn_table["ore_vein"]["extra_constant_table"]["ore_rnd_factor"] .. "|"
    )

end

---------------------------------------------------------------------------------------------------
-- Local functions (formspec "convert" buttons)
---------------------------------------------------------------------------------------------------

local function convert_biome_text(tab_type, fields)

    local convert_list = unilib.utils.split_string_by_separator(fields.main_convert_field)

    tab_data_table[tab_type]["biome_name"] = convert_list[1] or ""
    tab_data_table[tab_type]["biome_descrip"] = convert_list[2] or ""
    tab_data_table[tab_type]["biome_max"] = convert_list[15] or ""
    tab_data_table[tab_type]["biome_min"] = convert_list[16] or ""
    tab_data_table[tab_type]["biome_blend"] = convert_list[17] or ""
    tab_data_table[tab_type]["biome_heat"] = convert_list[18] or ""
    tab_data_table[tab_type]["biome_humidity"] = convert_list[19] or ""
    tab_data_table[tab_type]["biome_dust"] = convert_list[3] or ""
    tab_data_table[tab_type]["biome_top"] = convert_list[4] or ""
    tab_data_table[tab_type]["biome_fill"] = convert_list[5] or ""
    tab_data_table[tab_type]["biome_stone"] = convert_list[6] or ""
    tab_data_table[tab_type]["biome_water_top"] = convert_list[7] or ""
    tab_data_table[tab_type]["biome_water"] = convert_list[8] or ""
    tab_data_table[tab_type]["biome_river"] = convert_list[9] or ""
    tab_data_table[tab_type]["biome_riverbed"] = convert_list[10] or ""
    tab_data_table[tab_type]["biome_cave_liquid"] = convert_list[11] or ""
    tab_data_table[tab_type]["biome_dungeon"] = convert_list[12] or ""
    tab_data_table[tab_type]["biome_dungeon_alt"] = convert_list[13] or ""
    tab_data_table[tab_type]["biome_dungeon_stair"] = convert_list[14] or ""

end

local function convert_decoration_text(tab_type, fields)

    local convert_list = unilib.utils.split_string_by_separator(fields.main_convert_field)
    local type_list = tab_defn_table[tab_type]["type_list"]

    tab_data_table[tab_type]["deco_type"] = find_index_in_list(type_list, convert_list[1]) or 1
    tab_data_table[tab_type]["deco_name"] = convert_list[2] or ""
    tab_data_table[tab_type]["deco_max"] = convert_list[3] or ""
    tab_data_table[tab_type]["deco_min"] = convert_list[4] or ""
    tab_data_table[tab_type]["deco_biomes"] = convert_list[5] or ""
    tab_data_table[tab_type]["deco_place_on"] = convert_list[6] or ""
    tab_data_table[tab_type]["deco_spawn_by"] = convert_list[7] or ""
    tab_data_table[tab_type]["deco_num_spawn"] = convert_list[8] or ""
    tab_data_table[tab_type]["deco_fill_ratio"] = convert_list[9] or ""
    tab_data_table[tab_type]["deco_rnd_height"] = convert_list[10] or ""
    tab_data_table[tab_type]["deco_flags"] = convert_list[11] or ""
    tab_data_table[tab_type]["deco_sidelen"] = convert_list[12] or ""

end

local function convert_ore_text(tab_type, fields)

    local convert_list = unilib.utils.split_string_by_separator(fields.main_convert_field)

    tab_data_table[tab_type]["ore_name"] = convert_list[1] or ""
    tab_data_table[tab_type]["ore_param2"] = convert_list[2] or ""
    tab_data_table[tab_type]["ore_wherein"] = convert_list[3] or ""
    tab_data_table[tab_type]["ore_scarcity"] = convert_list[4] or ""
    tab_data_table[tab_type]["ore_num"] = convert_list[5] or ""
    tab_data_table[tab_type]["ore_size"] = convert_list[6] or ""
    tab_data_table[tab_type]["ore_max"] = convert_list[7] or ""
    tab_data_table[tab_type]["ore_min"] = convert_list[8] or ""
    tab_data_table[tab_type]["ore_flags"] = convert_list[9] or ""
    tab_data_table[tab_type]["ore_threshold"] = convert_list[10] or ""
    tab_data_table[tab_type]["ore_np_offset"] = convert_list[11] or ""
    tab_data_table[tab_type]["ore_np_scale"] = convert_list[12] or ""
    tab_data_table[tab_type]["ore_np_spread"] = convert_list[13] or ""
    tab_data_table[tab_type]["ore_np_seed"] = convert_list[14] or ""
    tab_data_table[tab_type]["ore_np_octaves"] = convert_list[15] or ""
    tab_data_table[tab_type]["ore_np_persist"] = convert_list[16] or ""
    tab_data_table[tab_type]["ore_biomes"] = convert_list[17] or ""

    if tab_type == "ore_blob" then

        tab_data_table[tab_type]["ore_type"] = 1

    elseif tab_type == "ore_puff" then

        tab_data_table[tab_type]["ore_type"] = 2
        tab_data_table[tab_type]["ore_nppt_offset"] = convert_list[18] or ""
        tab_data_table[tab_type]["ore_nppt_scale"] = convert_list[19] or ""
        tab_data_table[tab_type]["ore_nppt_spread"] = convert_list[20] or ""
        tab_data_table[tab_type]["ore_nppt_seed"] = convert_list[21] or ""
        tab_data_table[tab_type]["ore_nppt_octaves"] = convert_list[22] or ""
        tab_data_table[tab_type]["ore_nppt_persist"] = convert_list[23] or ""
        tab_data_table[tab_type]["ore_nppb_offset"] = convert_list[24] or ""
        tab_data_table[tab_type]["ore_nppb_scale"] = convert_list[25] or ""
        tab_data_table[tab_type]["ore_nppb_spread"] = convert_list[26] or ""
        tab_data_table[tab_type]["ore_nppb_seed"] = convert_list[27] or ""
        tab_data_table[tab_type]["ore_nppb_octaves"] = convert_list[28] or ""
        tab_data_table[tab_type]["ore_nppb_persist"] = convert_list[29] or ""

    elseif tab_type == "ore_scatter" then

        tab_data_table[tab_type]["ore_type"] = 3

    elseif tab_type == "ore_sheet" then

        tab_data_table[tab_type]["ore_type"] = 4
        tab_data_table[tab_type]["ore_column_max"] = convert_list[18] or ""
        tab_data_table[tab_type]["ore_column_min"] = convert_list[19] or ""
        tab_data_table[tab_type]["ore_column_mid"] = convert_list[20] or ""

    elseif tab_type == "ore_stratum" then

        tab_data_table[tab_type]["ore_type"] = 5
        tab_data_table[tab_type]["ore_npst_offset"] = convert_list[18] or ""
        tab_data_table[tab_type]["ore_npst_scale"] = convert_list[19] or ""
        tab_data_table[tab_type]["ore_npst_spread"] = convert_list[20] or ""
        tab_data_table[tab_type]["ore_npst_seed"] = convert_list[21] or ""
        tab_data_table[tab_type]["ore_npst_octaves"] = convert_list[22] or ""
        tab_data_table[tab_type]["ore_npst_persist"] = convert_list[23] or ""
        tab_data_table[tab_type]["ore_stratum_thick"] = convert_list[24] or ""

    elseif tab_type == "ore_vein" then

        tab_data_table[tab_type]["ore_type"] = 6
        tab_data_table[tab_type]["ore_rnd_factor"] = convert_list[18] or ""

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (formspec response code, support functions)
---------------------------------------------------------------------------------------------------

local function do_add_package(pname, tab_type, fields, pkg_mod)

    local pkg_name = unilib.utils.strip_whitespace(fields.pkg_name_field)
    if pkg_name ~= "" then

        local new_text = pkg_name
        if fields.pkg_mod_field ~= nil and pkg_mod ~= "" then
            new_text = new_text .. "|" .. pkg_mod
        end

        unilib.gui.update_notepad_in_edit_formspec(fields.main_notepad, new_text)

    end

    tab_data_table[tab_type]["pkg_mod"] = pkg_mod or ""
    core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

end

local function do_search_packages(pname, tab_type, fields, pkg_mod)

    local pkg_search = unilib.utils.strip_whitespace(fields.pkg_search_field)
    pkg_search:gsub("%s+", " ")
    tab_data_table[tab_type]["pkg_search"] = pkg_search

    if pkg_search ~= "" then
        do_pkg_search(pkg_search)
    else
        do_pkg_search()
    end

    tab_data_table[tab_type]["pkg_mod"] = pkg_mod or ""
    core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

end

---------------------------------------------------------------------------------------------------
-- Local functions (formspec response code, main functions)
---------------------------------------------------------------------------------------------------

local function respond_to_package_formspec(pname, tab_type, fields)

    local pkg_mod = unilib.utils.strip_whitespace(fields.pkg_mod_field)

    if fields.key_enter_field then

        if (
            fields.key_enter_field == "pkg_name_field" or
            fields.key_enter_field == "pkg_mod_field"
        ) and (
            fields.pkg_name_field ~= nil and
            fields.pkg_name_field ~= ""
        ) then
            do_add_package(pname, tab_type, fields, pkg_mod)
        elseif fields.key_enter_field == "pkg_search_field" and
                fields.pkg_search_field ~= nil and
                fields.pkg_search_field ~= "" then
            do_search_packages(pname, tab_type, fields, pkg_mod)
        else
            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))
        end

    elseif fields.pkg_name_list then

        local event = core.explode_textlist_event(fields.pkg_name_list)
        local index = event.index

        -- (Double-click)
        if fields.pkg_name_list:sub(1, 3) == "DCL" then

            local new_text
            if select_pkg_list ~= nil then
                new_text = select_pkg_list[index]
            else
                new_text = all_pkg_list[index]
            end

            if fields.pkg_mod_field ~= nil and pkg_mod ~= "" then
                new_text = new_text .. "|" .. pkg_mod
            end

            unilib.gui.update_notepad_in_edit_formspec(fields.main_notepad, new_text)

        end

        tab_data_table[tab_type]["pkg_mod"] = pkg_mod or ""
        core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

    elseif fields.pkg_unsearch_btn then

        do_pkg_search()

        tab_data_table[tab_type]["pkg_search"] = ""
        tab_data_table[tab_type]["pkg_mod"] = pkg_mod or ""
        core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

    elseif fields.pkg_reload_btn then

        all_pkg_list = nil
        select_pkg_list = nil
        tab_data_table[tab_type]["pkg_search"] = ""
        tab_data_table[tab_type]["pkg_mod"] = pkg_mod or ""
        core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

    elseif fields.pkg_search_btn or
            (fields.pkg_search_field ~= nil and fields.pkg_search_field ~= "") then

        do_search_packages(pname, tab_type, fields, pkg_mod)

    elseif fields.pkg_name_field ~= nil and fields.pkg_name_field ~= "" then

        do_add_package(pname, tab_type, fields, pkg_mod)

    end

end

local function respond_to_constant_formspec(pname, tab_type, fields)

    if fields.constant_add_btn or (
        fields.key_enter_field and (
            fields.key_enter_field == "constant_name_field" or
            fields.key_enter_field == "constant_value_field"
        )
    ) then

        local name = unilib.utils.strip_whitespace(fields.constant_name_field)
        local value = unilib.utils.strip_whitespace(fields.constant_value_field)

        if name ~= "" then
            unilib.gui.update_notepad_in_edit_formspec(fields.main_notepad, name .. "|" .. value)
        end

        tab_data_table[tab_type]["constant_name"] = ""
        tab_data_table[tab_type]["constant_value"] = ""
        core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

    else

        -- Handle optional buttons
        for btn_name, func in pairs(button_func_table) do

            if fields[btn_name] then
                func(tab_type, fields)
            end

        end

        tab_data_table[tab_type]["constant_name"] = fields.constant_name_field
        tab_data_table[tab_type]["constant_value"] = fields.constant_value_field
        core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

    end

end

local function respond_to_biome_formspec(pname, tab_type, fields)

    local prop_list = tab_defn_table[tab_type]["prop_list"]

    if fields.biome_clear_btn then

        for _, prop in ipairs(prop_list) do
            tab_data_table[tab_type][prop] = nil
        end

    else

        local biome_name = unilib.utils.strip_whitespace(fields.biome_name_field)
        store_biome_fields(tab_type, fields)

        if fields.biome_insert_btn then

            -- When using the insert button, don't overwrite the "Biome name" field
            tab_data_table[tab_type]["biome_name"] = biome_name

            for _, prop in ipairs(prop_list) do

                if tab_data_table[tab_type][prop] == nil or
                        tab_data_table[tab_type][prop] == "" then

                    tab_data_table[tab_type][prop] =
                            tab_defn_table[tab_type]["constant_table"][prop]

                end

            end

        elseif (
            fields.biome_add_btn or
            (fields.key_enter_field and fields.key_enter_field == "biome_name_field")
        ) and biome_name ~= "" then

            -- When text is sent to the main notepad, empty the "Biome name" field
            tab_data_table[tab_type]["biome_name"] = ""

            -- Biome name|Description|Original biome name|Dust node|Top node and depth|Fill node and depth|Stone node|Top water node and depth|Water node|River node|Riverbed node and depth|Cave liquid node|Dungeon node|Dungeon alternative node|Dungeon stair node|Max height|Min height|Vertical blend|Heat|Humidity
            unilib.gui.update_notepad_in_edit_formspec(
                fields.main_notepad,
                biome_name ..
                    "|" .. tab_data_table[tab_type]["biome_descrip"] ..
                    "|" ..          -- Original biome name, omitted
                    "|" .. tab_data_table[tab_type]["biome_dust"] ..
                    "|" .. tab_data_table[tab_type]["biome_top"] ..
                    "|" .. tab_data_table[tab_type]["biome_fill"] ..
                    "|" .. tab_data_table[tab_type]["biome_stone"] ..
                    "|" .. tab_data_table[tab_type]["biome_water_top"] ..
                    "|" .. tab_data_table[tab_type]["biome_water"] ..
                    "|" .. tab_data_table[tab_type]["biome_river"] ..
                    "|" .. tab_data_table[tab_type]["biome_riverbed"] ..
                    "|" .. tab_data_table[tab_type]["biome_cave_liquid"] ..
                    "|" .. tab_data_table[tab_type]["biome_dungeon"] ..
                    "|" .. tab_data_table[tab_type]["biome_dungeon_alt"] ..
                    "|" .. tab_data_table[tab_type]["biome_dungeon_stair"] ..
                    "|" .. tab_data_table[tab_type]["biome_max"] ..
                    "|" .. tab_data_table[tab_type]["biome_min"] ..
                    "|" .. tab_data_table[tab_type]["biome_blend"] ..
                    "|" .. tab_data_table[tab_type]["biome_heat"] ..
                    "|" .. tab_data_table[tab_type]["biome_humidity"]
            )

        elseif fields.key_enter_field then

            -- User has pressed ENTER in a field other than the "Biome name" field; preserve the
            --      contents of that field for next time
            tab_data_table[tab_type]["biome_name"] = biome_name

        end

    end

    core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

end

local function respond_to_decoration_formspec(pname, tab_type, fields)

    local prop_list = tab_defn_table[tab_type]["prop_list"]

    if fields.deco_clear_btn then

        for _, prop in ipairs(prop_list) do
            tab_data_table[tab_type][prop] = nil
        end

    else

        local deco_name = unilib.utils.strip_whitespace(fields.deco_name_field)
        store_decoration_fields(tab_type, fields)

        if fields.deco_insert_btn then

            -- When using the insert button, don't overwrite the "Node name" field
            tab_data_table[tab_type]["deco_name"] = deco_name

            for _, prop in ipairs(prop_list) do

                if tab_data_table[tab_type][prop] == nil or
                        tab_data_table[tab_type][prop] == "" then

                    tab_data_table[tab_type][prop] =
                            tab_defn_table[tab_type]["constant_table"][prop]

                end

            end

        elseif (
            fields.deco_add_btn or
            (fields.key_enter_field and fields.key_enter_field == "deco_name_field")
        ) and deco_name ~= "" then

            -- When text is sent to the main notepad, empty the "Node name" field
            tab_data_table[tab_type]["deco_name"] = ""

            local type_list = tab_defn_table[tab_type]["type_list"]
            -- Deco type|Deco name|Max height|Min height|Biomes|Place on|Spawn by|Num spawn by|Fill ratio|Height max|Flags|Side length
            unilib.gui.update_notepad_in_edit_formspec(
                fields.main_notepad,
                type_list[tab_data_table[tab_type]["deco_type"]] ..
                    "|" .. deco_name ..
                    "|" .. tab_data_table[tab_type]["deco_max"] ..
                    "|" .. tab_data_table[tab_type]["deco_min"] ..
                    "|" .. tab_data_table[tab_type]["deco_biomes"] ..
                    "|" .. tab_data_table[tab_type]["deco_place_on"] ..
                    "|" .. tab_data_table[tab_type]["deco_spawn_by"] ..
                    "|" .. tab_data_table[tab_type]["deco_num_spawn"] ..
                    "|" .. tab_data_table[tab_type]["deco_fill_ratio"] ..
                    "|" .. tab_data_table[tab_type]["deco_rnd_height"] ..
                    "|" .. tab_data_table[tab_type]["deco_flags"] ..
                    "|" .. tab_data_table[tab_type]["deco_sidelen"]
            )

        elseif fields.key_enter_field then

            -- User has pressed ENTER in a field other than the "Node name" field; preserve the
            --      contents of that field for next time
            tab_data_table[tab_type]["deco_name"] = deco_name

        end

    end

    core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

end

local function respond_to_ore_formspec(pname, tab_type, fields)

    local prev_ore_type = tab_data_table[tab_type]["ore_type"]
    local prop_list = tab_defn_table[tab_type]["prop_list"]
    local extra_prop_list = tab_defn_table[tab_type]["extra_prop_list"] or {}

    if fields.ore_clear_btn then

        for _, prop in ipairs(prop_list) do
            tab_data_table[tab_type][prop] = nil
        end

        for _, prop in ipairs(extra_prop_list) do
            tab_data_table[tab_type][prop] = nil
        end

    else

        local ore_name = unilib.utils.strip_whitespace(fields.ore_name_field)
        local ore_type = tonumber(unilib.utils.strip_whitespace(fields.ore_type_dbox))

        if fields.ore_type_dbox then

            -- (For convenience, all ore tabs store the current ore type in their data)
            tab_data_table["ore_blob"]["ore_type"] = ore_type
            tab_data_table["ore_puff"]["ore_type"] = ore_type
            tab_data_table["ore_scatter"]["ore_type"] = ore_type
            tab_data_table["ore_sheet"]["ore_type"] = ore_type
            tab_data_table["ore_stratum"]["ore_type"] = ore_type
            tab_data_table["ore_vein"]["ore_type"] = ore_type

            substitute_tab("ore", "ore_" .. default_ore_type_list[ore_type])

        end

        store_ore_fields(tab_type, fields)

        if fields.ore_insert_btn then

            -- When using the insert button, don't overwrite the "Ore" field
            tab_data_table[tab_type]["ore_name"] = ore_name

            for _, prop in ipairs(prop_list) do

                if tab_data_table[tab_type][prop] == nil or
                        tab_data_table[tab_type][prop] == "" then

                    tab_data_table[tab_type][prop] =
                            tab_defn_table[tab_type]["constant_table"][prop]

                end

            end

            for _, prop in ipairs(extra_prop_list) do

                if tab_data_table[tab_type][prop] == nil or
                        tab_data_table[tab_type][prop] == "" then

                    tab_data_table[tab_type][prop] =
                            tab_defn_table[tab_type]["extra_constant_table"][prop]

                end

            end

        elseif (
            fields.ore_add_btn or
            (fields.key_enter_field and fields.key_enter_field == "ore_name_field")
        ) and ore_name ~= "" then

            -- When text is sent to the main notepad, empty the "Ore" field
            tab_data_table[tab_type]["ore_name"] = ""

            -- ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes
            -- ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|nppt_offset|nppt_scale|nppt_spread|nppt_seed|nppt_octaves|nppt_persist|nppb_offset|nppb_scale|nppb_spread|nppb_seed|nppb_octaves|nppb_persist
            -- ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes
            -- ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|column_height_max|column_height_min|column_midpoint_factor
            -- ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|npst_offset|npst_scale|npst_spread|npst_seed|npst_octaves|npst_persist|stratum_thickness
            -- ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|random_factor
            local text = ore_name ..
                "|" .. tab_data_table[tab_type]["ore_param2"] ..
                "|" .. tab_data_table[tab_type]["ore_wherein"] ..
                "|" .. tab_data_table[tab_type]["ore_scarcity"] ..
                "|" .. tab_data_table[tab_type]["ore_num"] ..
                "|" .. tab_data_table[tab_type]["ore_size"] ..
                "|" .. tab_data_table[tab_type]["ore_max"] ..
                "|" .. tab_data_table[tab_type]["ore_min"] ..
                "|" .. tab_data_table[tab_type]["ore_flags"] ..
                "|" .. tab_data_table[tab_type]["ore_threshold"] ..
                "|" .. tab_data_table[tab_type]["ore_np_offset"] ..
                "|" .. tab_data_table[tab_type]["ore_np_scale"] ..
                "|" .. tab_data_table[tab_type]["ore_np_spread"] ..
                "|" .. tab_data_table[tab_type]["ore_np_seed"] ..
                "|" .. tab_data_table[tab_type]["ore_np_octaves"] ..
                "|" .. tab_data_table[tab_type]["ore_np_persist"] ..
                "|" .. tab_data_table[tab_type]["ore_biomes"]

            if ore_type == 2 then

                text = text ..
                    "|" .. tab_data_table[tab_type]["ore_nppt_offset"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppt_scale"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppt_spread"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppt_seed"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppt_octaves"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppt_persist"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppb_offset"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppb_scale"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppb_spread"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppb_seed"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppb_octaves"] ..
                    "|" .. tab_data_table[tab_type]["ore_nppb_persist"]

            elseif ore_type == 4 then

                text = text ..
                    "|" .. tab_data_table[tab_type]["ore_column_max"] ..
                    "|" .. tab_data_table[tab_type]["ore_column_min"] ..
                    "|" .. tab_data_table[tab_type]["ore_column_mid"]

            elseif ore_type == 5 then

                text = text ..
                    "|" .. tab_data_table[tab_type]["ore_npst_offset"] ..
                    "|" .. tab_data_table[tab_type]["ore_npst_scale"] ..
                    "|" .. tab_data_table[tab_type]["ore_npst_spread"] ..
                    "|" .. tab_data_table[tab_type]["ore_npst_seed"] ..
                    "|" .. tab_data_table[tab_type]["ore_npst_octaves"] ..
                    "|" .. tab_data_table[tab_type]["ore_npst_persist"] ..
                    "|" .. tab_data_table[tab_type]["ore_stratum_thick"]

            elseif ore_type == 6 then

                text = text ..
                    "|" .. tab_data_table[tab_type]["ore_rnd_factor"]

            end

            unilib.gui.update_notepad_in_edit_formspec(fields.main_notepad, text)

        elseif fields.key_enter_field then

            -- User has pressed ENTER in a field other than the "Ore" field; preserve the contents
            --      of that field for next time
            tab_data_table[tab_type]["ore_name"] = ore_name

        end

    end

    core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

end

---------------------------------------------------------------------------------------------------
-- Local functions (called by unilib.gui._open_edit_formspec() )
---------------------------------------------------------------------------------------------------

local function get_standard_remix_path(remix_name)

    for _, folder_path in ipairs(unilib.global.remix_path_list) do

        for _, this_remix_name in ipairs(core.get_dir_list(folder_path, true)) do

            if this_remix_name == remix_name then
                return folder_path .. remix_name .. "/"
            end

        end

    end

end

local function does_editable_remix_exist(pname, remix_name)

    -- ../lib/system/gui/gui_create.lua creates a remix folder inside the unilib's mod storage
    --      folder (as we're not allowed to write to unilib's own folder directly)
    -- If a remix with the specified name doesn't already exist at that location, we can make a copy
    --      of a remix with the same name from any of the standard locations

    -- Check for a valid "remix_name"
    remix_name = unilib.utils.strip_whitespace(remix_name)
    if remix_name == "" then

        -- (The same error message used in the "chat_edit_remix" package, as if the check had been
        --      done there)
        unilib.utils.chat_send_player(pname, which_msg)
        return false

    end

    -- The remix exists, if a folder called "remix_name" containing a packages.csv file exists
    local output_remix_path = get_path(remix_name)
    if unilib.utils.is_file(output_remix_path .. "packages.csv") then
        return true
    end

    -- No remix found in unilib's mod storage folder, so try to make a copy of one from the standard
    --      locations (the copy can be edited in-game)
    local source_remix_path = get_standard_remix_path(remix_name)
    if not source_remix_path then

        unilib.utils.chat_send_player(pname, which_msg)
        return false

    end

    if not core.mkdir(output_remix_path) then

        unilib.utils.chat_send_player(
            pname,
            S("Unable to copy the \"@1\" remix into an editable location")
        )

        return false

    end

    local failure_list = {}
    local success_list = {}

    for _, this_file_name in ipairs(core.get_dir_list(source_remix_path, false)) do

        local source_file_path = source_remix_path .. this_file_name
        local output_file_path = output_remix_path .. this_file_name

        -- Read the source file
        local file = io.open(source_file_path, "rb")
        if file then

            local file2 = io.open(output_file_path, "wb")
            if file2 then

                file2:write(file:read("*all"))
                file2:close()

            end

            file:close()

        end

        if not unilib.utils.is_file(output_file_path) then
            table.insert(failure_list, this_file_name)
        else
            table.insert(success_list, this_file_name)
        end

    end

    -- Copy operation complete
    if #failure_list == 0 then

        unilib.utils.chat_send_player(
            pname,
            S(
                "Copied the remix @1 to @2 [copying @3 files]. The copy is now available for" ..
                    " editing",
                source_remix_path,
                output_remix_path,
                #success_list
            )
        )

        return true

    elseif #success_list > 0 then

        unilib.utils.chat_send_player(
            pname,
            S(
                "Copied the remix @1 to @2 [copying @3 files], but could not copy some files: @4",
                source_remix_path,
                output_remix_path,
                #success_list,
                table.concat(fail_list, " ")
            )
        )

        return true

    else

        unilib.utils.chat_send_player(
            pname,
            S(
                "Failed to copy any files from the remix @1",
                source_remix_path
            )
        )

        return false

    end

end

local function init_package_data(remix_name, tab_type)

    -- Called to initialise the "Packages" tab

    tab_data_table[tab_type]["pkg_mod"] = ""
    tab_data_table[tab_type]["pkg_search"] = ""

end

local function init_constant_data(remix_name, tab_type)

    -- Called to initialise the "Constants" tab

    tab_data_table[tab_type]["constant_name"] = ""
    tab_data_table[tab_type]["constant_value"] = ""

end

local function init_decoration_data(remix_name, tab_type)

    -- Called to initialise the "Decorations" tab

    tab_data_table[tab_type]["deco_type"] = 1

end

local function init_ore_data(remix_name, tab_type)

    -- Called to initialise the "Ores" tab

    tab_data_table[tab_type]["ore_type"] = tab_defn_table[tab_type]["type_list_index"]

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.gui._add_tab_to_edit_formspec(tab_type, tab_defn)

    -- Sanity checks
    if tab_defn.category == nil or
            tab_defn.label == nil or
            tab_defn.file == nil then

        unilib.utils.show_warning(
            "unilib.gui.add_tab_to_edit_formspec(): Missing fields in tab definition", tab_type
        )

        return

    elseif tab_defn_table[tab_type] ~= nil then

        unilib.utils.show_warning(
            "unilib.gui.add_tab_to_edit_formspec(): Cannot add duplicate tab", tab_type
        )

        return

    end

    -- Update local variables
    insert_tab(tab_defn.category, tab_type)
    tab_defn_table[tab_type] = tab_defn

end

function unilib.gui._get_remix_for_edit_formspec()

    return current_remix_name

end

function unilib.gui._get_tab_data_from_edit_formspec(tab_type)

    return tab_data_table[tab_type]

end

function unilib.gui._get_tab_defn_from_edit_formspec(tab_type)

    return tab_defn_table[tab_type]

end

function unilib.gui._open_edit_formspec(pname, remix_name)

    -- (Allow the player to resume editing the previous remix, by typing /edit_remix)
    if remix_name == nil or remix_name == "" then

        if current_remix_name == nil then

            unilib.utils.chat_send_player(pname, which_msg)
            return

        else

            remix_name = current_remix_name

        end

    else

        remix_name = unilib.utils.strip_whitespace(remix_name)

    end

    if does_editable_remix_exist(pname, remix_name) then

        -- (If editing the first remix of this session, or if editing a different remix than the
        --      last time, reset variables)
        if current_remix_name == nil or current_remix_name ~= remix_name then

            -- Initialise "tab_data_table". A few tabs have their own initialisation functions, but
            --      for most, it's enough just to initialise the .content field
            for tab_type, _ in pairs(tab_defn_table) do

                tab_data_table[tab_type] = {
                    content = load_file(remix_name, tab_type),
                }

                if tab_defn_table[tab_type]["init_func"] ~= nil then
                    tab_defn_table[tab_type]["init_func"](remix_name, tab_type)
                end

            end

        end

        current_remix_name = remix_name
        current_tab = 1

        core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

    end

end

function unilib.gui._redisplay_edit_formspec(pname)

    core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

end

function unilib.gui._save_edit_formspec_content(tab_type)

    local data_table = tab_data_table[tab_type]
    if data_table == nil then
        return
    end

    local content = data_table.content or ""
    save_file(tab_defn_table[tab_type]["file"], content)

end

function unilib.gui._set_tab_data_for_edit_formspec(tab_type, data_table)

    tab_data_table[tab_type] = data_table

end

function unilib.gui._update_notepad_in_edit_formspec(old_text, new_text)

    -- Must be followed by a call to core.show_formspec(), usually via a call to
    --      unilib.gui.redisplay_edit_formspec()

    local tab_type = tab_display_list[current_tab]

    if old_text:match("^%s*$") then
        tab_data_table[tab_type]["content"] = new_text
    elseif old_text:match("\n%s*$") then
        tab_data_table[tab_type]["content"] = old_text:gsub("\n%s*$", "\n" .. new_text)
    else
        tab_data_table[tab_type]["content"] = old_text .. "\n" .. new_text
    end

end

---------------------------------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------------------------------

-- We can now populate the data lists, which include some of the functions above
tab_display_list = {
    "package", "description", "label", "constant", "biome", "decoration", "ore_blob",
}
tab_defn_table = {
    package = {
        category = "package",
        label = FS("Packages"),
        file = "packages.csv",

        init_func = init_package_data,
        formspec_func = get_package_formspec_section,
        response_func = respond_to_package_formspec,
    },
    description = {
        category = "description",
        label = FS("Description"),
        file = "description.csv",

        formspec_func = get_description_formspec_section,
    },
    label = {
        category = "label",
        label = FS("Labels"),
        file = "labels.csv",

        formspec_func = get_label_formspec_section,
    },
    constant = {
        category = "constant",
        label = FS("Constants"),
        file = "constants.csv",

        init_func = init_constant_data,
        formspec_func = get_constant_formspec_section,
        response_func = respond_to_constant_formspec,
    },
    biome = {
        category = "biome",
        label = FS("Biomes"),
        file = "biomes.csv",

        formspec_func = get_biome_formspec_section,
        storage_func = store_biome_fields,
        response_func = respond_to_biome_formspec,
        convert_func = convert_biome_text,

        add_constant_label = FS("Add biome constants"),
        add_constant_func = add_biome_constants,

        constant_table = {
            biome_descrip = "NO_DESCRIP",
            biome_dust = "NO_DUST",
            biome_top = "NO_TOP",
            biome_fill = "NO_FILL",
            biome_stone = "NO_STONE",
            biome_water_top = "NO_WATER_TOP",
            biome_water = "NO_WATER",
            biome_river = "NO_RIVER",
            biome_riverbed = "NO_RIVER_BED",
            biome_cave_liquid = "NO_CAVE_LIQUID",
            biome_dungeon = "NO_DUNGEON",
            biome_dungeon_alt = "NO_ALT_DUNGEON",
            biome_dungeon_stair = "NO_DUNGEON_STAIR",
            biome_max = "NO_MAX_HEIGHT",
            biome_min = "NO_MIN_HEIGHT",
            biome_blend = "NO_BLEND",
            biome_heat = "NO_HEAT",
            biome_humidity = "NO_HUMIDITY",
        },
        prop_list = {
            "biome_descrip", "biome_max", "biome_min", "biome_blend", "biome_heat",
            "biome_humidity", "biome_dust", "biome_top", "biome_fill", "biome_stone",
            "biome_water_top", "biome_water", "biome_river", "biome_riverbed", "biome_cave_liquid",
            "biome_dungeon", "biome_dungeon_alt", "biome_dungeon_stair",
        },
    },
    decoration = {
        category = "decoration",
        label = FS("Decorations"),
        file = "decorations.csv",

        init_func = init_decoration_data,
        formspec_func = get_decoration_formspec_section,
        storage_func = store_decoration_fields,
        response_func = respond_to_decoration_formspec,
        convert_func = convert_decoration_text,

        add_constant_label = FS("Add decoration constants"),
        add_constant_func = add_decoration_constants,

        constant_table = {
            deco_max = "NO_MAX_HEIGHT",
            deco_min = "NO_MIN_HEIGHT",
            deco_biomes = "NO_BIOMES",
            deco_place_on = "NO_PLACE_ON",
            deco_spawn_by = "NO_SPAWN_BY",
            deco_num_spawn = "NO_NUM_SPAWN_BY",
            deco_fill_ratio = "NO_FILL_RATIO",
            deco_rnd_height = "NO_RND_HEIGHT",
            deco_flags = "NO_FLAGS",
            deco_sidelen = "NO_SIDELEN",
        },
        prop_list = {
            "deco_max", "deco_min", "deco_biomes", "deco_place_on", "deco_spawn_by",
            "deco_num_spawn", "deco_fill_ratio", "deco_rnd_height", "deco_flags", "deco_sidelen",
        },
        type_list = {"simple", "schematic", "schematic_no_rotate", "treelog"},
    },
    ore_blob = {
        category = "ore",
        label = FS("Ores"),
        file = "ore_blob.csv",

        init_func = init_ore_data,
        formspec_func = get_ore_formspec_section,
        storage_func = store_ore_fields,
        response_func = respond_to_ore_formspec,
        convert_func = convert_ore_text,

        add_constant_label = FS("Add ore constants"),
        add_constant_func = add_ore_constants,

        constant_table = default_ore_constant_table,
        prop_list = default_ore_prop_list,
        type_list = default_ore_type_list,
        type_list_index = 1,
    },
    ore_puff = {
        category = "ore",
        label = FS("Ores"),
        file = "ore_puff.csv",

        init_func = init_ore_data,
        formspec_func = get_ore_formspec_section,
        storage_func = store_ore_fields,
        response_func = respond_to_ore_formspec,
        convert_func = convert_ore_text,

        add_constant_label = FS("Add ore constants"),
        add_constant_func = add_ore_constants,

        constant_table = default_ore_constant_table,
        extra_constant_table = {
            ore_nppt_offset = "NO_NPPT_OFFSET",
            ore_nppt_scale = "NO_NPPT_SCALE",
            ore_nppt_spread = "NO_NPPT_SPREAD",
            ore_nppt_seed = "NO_NPPT_SEED",
            ore_nppt_octaves = "NO_NPPT_OCTAVES",
            ore_nppt_persist = "NO_NPPT_PERSIST",
            ore_nppb_offset = "NO_NPPB_OFFSET",
            ore_nppb_scale = "NO_NPPB_SCALE",
            ore_nppb_spread = "NO_NPPB_SPREAD",
            ore_nppb_seed = "NO_NPPB_SEED",
            ore_nppb_octaves = "NO_NPPB_OCTAVES",
            ore_nppb_persist = "NO_NPPB_PERSIST",
        },
        prop_list = default_ore_prop_list,
        extra_prop_list = {
            "ore_nppt_offset", "ore_nppt_scale", "ore_nppt_spread", "ore_nppt_seed",
            "ore_nppt_octaves", "ore_nppt_persist", "ore_nppb_offset", "ore_nppb_scale",
            "ore_nppb_spread", "ore_nppb_seed", "ore_nppb_octaves", "ore_nppb_persist",
        },
        type_list = default_ore_type_list,
        type_list_index = 2,
    },
    ore_scatter = {
        category = "ore",
        label = FS("Ores"),
        file = "ore_scatter.csv",

        init_func = init_ore_data,
        formspec_func = get_ore_formspec_section,
        storage_func = store_ore_fields,
        response_func = respond_to_ore_formspec,
        convert_func = convert_ore_text,

        add_constant_label = FS("Add ore constants"),
        add_constant_func = add_ore_constants,

        constant_table = default_ore_constant_table,
        prop_list = default_ore_prop_list,
        type_list = default_ore_type_list,
        type_list_index = 3,
    },
    ore_sheet = {
        category = "ore",
        label = FS("Ores"),
        file = "ore_sheet.csv",

        init_func = init_ore_data,
        formspec_func = get_ore_formspec_section,
        storage_func = store_ore_fields,
        response_func = respond_to_ore_formspec,
        convert_func = convert_ore_text,

        add_constant_label = FS("Add ore constants"),
        add_constant_func = add_ore_constants,

        constant_table = default_ore_constant_table,
        extra_constant_table = {
            ore_column_max = "NO_COLUMN_MAX",
            ore_column_min = "NO_COLUMN_MIN",
            ore_column_mid = "NO_COLUMN_MIDPOINT",
        },
        prop_list = default_ore_prop_list,
        extra_prop_list = {
            "ore_column_max", "ore_column_min", "ore_column_mid",
        },
        type_list = default_ore_type_list,
        type_list_index = 4,
    },
    ore_stratum = {
        category = "ore",
        label = FS("Ores"),
        file = "ore_stratum.csv",

        init_func = init_ore_data,
        formspec_func = get_ore_formspec_section,
        storage_func = store_ore_fields,
        response_func = respond_to_ore_formspec,
        convert_func = convert_ore_text,

        add_constant_label = FS("Add ore constants"),
        add_constant_func = add_ore_constants,

        constant_table = default_ore_constant_table,
        extra_constant_table = {
            ore_npst_offset = "NO_NPST_OFFSET",
            ore_npst_scale = "NO_NPST_SCALE",
            ore_npst_spread = "NO_NPST_SPREAD",
            ore_npst_seed = "NO_NPST_SEED",
            ore_npst_octaves = "NO_NPST_OCTAVES",
            ore_npst_persist = "NO_NPST_PERSIST",
            ore_stratum_thick = "NO_STRATUM_THICK",
        },
        prop_list = default_ore_prop_list,
        extra_prop_list = {
            "ore_npst_offset", "ore_npst_scale", "ore_npst_spread", "ore_npst_seed",
            "ore_npst_octaves", "ore_npst_persist", "ore_stratum_thick",
        },
        type_list = default_ore_type_list,
        type_list_index = 5,
    },
    ore_vein = {
        category = "ore",
        label = FS("Ores"),
        file = "ore_vein.csv",

        init_func = init_ore_data,
        formspec_func = get_ore_formspec_section,
        storage_func = store_ore_fields,
        response_func = respond_to_ore_formspec,
        convert_func = convert_ore_text,

        add_constant_label = FS("Add ore constants"),
        add_constant_func = add_ore_constants,

        constant_table = default_ore_constant_table,
        extra_constant_table = {
            ore_rnd_factor = "NO_RND_FACTOR",
        },
        prop_list = default_ore_prop_list,
        extra_prop_list = {
            "ore_rnd_factor",
        },
        type_list = default_ore_type_list,
        type_list_index = 6,
    },
}

-- Respond to the player's actions

core.register_on_player_receive_fields(function(player, formname, fields)

    if formname ~= edit_formname and formname ~= confirm_formname then
        return false
    end

    local pname = player:get_player_name()

    if formname == edit_formname then

        local prev_tab = current_tab
        local prev_tab_type = tab_display_list[prev_tab]

        -- (Any player response restores the main notepad, if the "Convert" button was visible)
        split_notepad_flag = false

        -- Handle tab switching
        if fields.tabs then

            current_tab = tonumber(fields.tabs) or 1

            tab_data_table[prev_tab_type]["content"] = fields.main_notepad
            if tab_defn_table[prev_tab_type]["storage_func"] then
                tab_defn_table[prev_tab_type]["storage_func"](prev_tab_type, fields)
            end

            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

        -- Handle buttons common to most tabs
        elseif fields.main_warning_btn then

            tab_defn_table[prev_tab_type]["warning_call_func"](prev_tab_type, fields, pname)

        elseif fields.quit then

            -- Nothing to do - unilib.gui._open_edit_formspec() handles resetting the tab states
            -- Note that this condition follows the check for fields.main_warning_btn, because it's
            --      an image_button_exit[] element that generates a fields.quit

        elseif fields.main_split_btn then

            split_notepad_flag = true
            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

        elseif fields.main_convert_btn then

            if unilib.utils.strip_whitespace(fields.main_convert_field) ~= "" and
                    tab_defn_table[prev_tab_type]["convert_func"] then
                tab_defn_table[prev_tab_type]["convert_func"](prev_tab_type, fields)
            end

            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

        elseif fields.main_reset_btn then

            tab_data_table[prev_tab_type]["content"] = fields.main_notepad
            if tab_defn_table[prev_tab_type]["storage_func"] then
                tab_defn_table[prev_tab_type]["storage_func"](prev_tab_type, fields)
            end

            core.show_formspec(pname, confirm_formname, get_confirm_formspec(pname))

        elseif fields.main_save_btn then

            local file_name = tab_defn_table[prev_tab_type]["file"]
            if not save_file(file_name, fields.main_notepad) then

                unilib.utils.chat_send_player(
                    pname,
                    S("FAILED to save file @1", file_name)
                )

            else

                unilib.utils.chat_send_player(
                    pname,
                    S("Saved file @1", file_name)
                )

            end

            tab_data_table[prev_tab_type]["content"] = fields.main_notepad
            if tab_defn_table[prev_tab_type]["storage_func"] then
                tab_defn_table[prev_tab_type]["storage_func"](prev_tab_type, fields)
            end

            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

        else

            -- N.B. It's the response function's responsibility to call core.show_formspec(), or
            --      not, as required
            if tab_defn_table[prev_tab_type]["response_func"] then
                tab_defn_table[prev_tab_type]["response_func"](pname, prev_tab_type, fields)
            else
                core.show_formspec(pname, edit_formname, get_edit_formspec(pname))
            end

        end

    else

        local tab_type = tab_display_list[current_tab]

        -- Handle the confirmation dialogue
        if fields.yes_btn then

            local file_name = tab_defn_table[tab_type]["file"]

            local new_content = load_file(current_remix_name, tab_type)
            if new_content == nil then

                unilib.utils.chat_send_player(
                    pname,
                    S("Failed to load file @1", file_name)
                )

            else

                tab_data_table[tab_type]["content"] = new_content

                unilib.utils.chat_send_player(
                    pname,
                    S("Re-loaded file @1", file_name)
                )

            end

            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

        elseif fields.no_btn then

            core.show_formspec(pname, edit_formname, get_edit_formspec(pname))

        end

    end

end)
