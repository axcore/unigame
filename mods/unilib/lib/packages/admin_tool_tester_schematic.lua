---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_tester_schematic = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- A list of known bush/tree offsets, populated below
-- Table in the form
--      known_offset_table[short_schematic_path] = {x = x_offset, y = y_offset, z = z_offset}
local known_offset_table = {}
-- Flag set to true, when this table has been compiled (only needs to be done once per session)
local known_offset_flag = false

-- Locations at which unilib stores schematic .mts files
local folder_list = {
    unilib.core.path_mod .. "/mts",
    unilib.core.path_mod .. "/custom/mts",
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_known_offsets()

    -- Called on the first use, in order to populate the table of known bush/tree offsets, ready
    --      for when they're needed

   for _, data_table in pairs(unilib.global.sapling_table) do

        if data_table.schem_list == nil then

            local mini_offset_table = {}
            if data_table.offset_list == nil then

                mini_offset_table = {x = 0, y = 0, z = 0}

            else

                mini_offset_table = {
                    x = data_table.offset_list[1] or 0,
                    y = data_table.offset_list[2] or 0,
                    z = data_table.offset_list[3] or 0,
                }

            end

            local schem_name = "unilib_" ..data_table.sapling_type .. "_" ..
                    data_table.part_name ..".mts"
            known_offset_table[schem_name] = mini_offset_table

            -- (../lib/shared/trees/trees_grow.lua applies the same offsets to a "_from_sapling"
            --      schematic)
            local from_sapling_schem_name = "unilib_" ..data_table.sapling_type .. "_" ..
                    data_table.part_name .."_from_sapling.mts"
            known_offset_table[from_sapling_schem_name] = mini_offset_table

        else

            for _, mini_list in pairs(data_table.schem_list) do

                -- "mini_list" in the form [schematic_name, x, y, z]
                local mini_offset_table = {x = 0, y = 0, z = 0}
                mini_offset_table.x = mini_list[2]
                mini_offset_table.y = mini_list[3]
                mini_offset_table.z = mini_list[4]

                known_offset_table[mini_list[1]] = mini_offset_table

            end

        end

    end

    -- This function only needs to be called once
    known_offset_flag = true

end

local function get_short_schem_list(meta)

    -- The metadata value "short_schem_listing" is a string of short paths to schematics, separated
    --      by newline characters
    -- Convert the string to a list, and return it

    local short_schem_listing = meta:get_string("short_schem_listing")

    local schem_list = {}
    for short_path in string.gmatch(short_schem_listing, "([^\n]+)") do
        table.insert(schem_list, short_path)
    end

    return schem_list

end

local function get_long_schem_list(meta)

    -- The metadata value "long_schem_listing" is a string of full paths to schematics, separated by
    --      newline characters
    -- Convert the string to a list, and return it

    local long_schem_listing = meta:get_string("long_schem_listing")

    local schem_list = {}
    for long_path in string.gmatch(long_schem_listing, "([^\n]+)") do
        table.insert(schem_list, long_path)
    end

    return schem_list

end

local function get_current_schem(meta)

    -- Retrieves the paths to the schematic specified by the metadata value "schem_index" (meaning,
    --      the next schematic to be placed in the world)
    -- Returns the short and full paths to the schematic file, or empty strings if no schematic is
    --      due to be placed in the world ("schem_index" is 0)

    local short_schem_list = get_short_schem_list(meta)
    local long_schem_list = get_long_schem_list(meta)

    local schem_index = meta:get_int("schem_index")
    if schem_index < 1 then
        return "", ""
    else
        return short_schem_list[schem_index], long_schem_list[schem_index]
    end

end

local function compose_display_listing(meta)

    -- After updating the metadata values "short_schem_listing" and "long_schem_listing", this
    --      function must be called to compile the string actually displayed in the formspec

    local schem_list
    if meta:get_string("show_long_paths") == "true" then
        schem_list = get_long_schem_list(meta)
    else
        schem_list = get_short_schem_list(meta)
    end

    local schem_index = meta:get_int("schem_index")

    local display_listing = ""
    local this_count = 0

    for _, path in ipairs(schem_list) do

        this_count = this_count + 1

        local adj_path
        if this_count == schem_index then
            adj_path = " * " .. path
        else
            adj_path = "   " .. path
        end

        if this_count == 1 then
            display_listing = adj_path
        else
            display_listing = display_listing .. "\n" .. adj_path
        end

    end

    return display_listing

end

local function get_formspec(itemstack, preserve_search)

    -- Return a string to be used in the formspec

    local meta = itemstack:get_meta()

    local matching_msg = ""
    local next_msg = ""

    if meta:get_int("schem_count") > 0 then

        matching_msg = S("Matching schematics")
        next_msg = S("Next schematic to place")

    end

    local short_path, long_path = get_current_schem(meta)
    local current_schem
    if meta:get_string("show_long_paths") == "true" then
        current_schem = long_path
    else
        current_schem = short_path
    end

    -- When one of the checkbuttons has been toggled, we try to preserve the contents of the
    --      search box using this optional argument
    if preserve_search == nil then
        preserve_search = ""
    end

    local formspec = "size[10,8]" ..
        "label[3.5,0;" .. FS("Schematic Placement Tool") .. "]" ..
        "field[0.5,1;5.5,1;search;" .. FS("Find schematics") .. ";" .. F(preserve_search) .. "]" ..
        "field_close_on_enter[search;false]" ..
        "button[5.75,0.675;2,1;showall;" .. FS("Show all") .. "]" ..
        "button[7.75,0.675;2,1;reset;" .. FS("Reset") .. "]" ..
        "textarea[0.5,2;9.5,3.75;;" .. F(matching_msg) .. ";" ..
                F(compose_display_listing(meta)) .. "]" ..
        "textarea[0.5,5.7;9.5,1;;" .. F(next_msg) .. ";" ..
                "   " .. F(current_schem) .. "]" ..
        "field_close_on_enter[next;false]" ..
        "checkbox[0.25,6.25;cycle;" .. FS("Cycle through schematics") .. ";" ..
                meta:get_string("use_cycle") .. "]" ..
        "checkbox[0.25,6.75;reverse;" .. FS("Cycle in reverse order") .. ";" ..
                meta:get_string("use_reverse_cycle") .. "]" ..
        "checkbox[0.25,7.25;chat;" .. FS("Show schematics in chat") .. ";" ..
                meta:get_string("show_in_chat") .. "]" ..
        "checkbox[5,6.25;column;" .. FS("Place schematics on column") .. ";" ..
                meta:get_string("place_column") .. "]" ..
        "checkbox[5,6.75;bushtree;" .. FS("Use bush and tree offsets") .. ";" ..
                meta:get_string("use_bush_tree_offsets") .. "]" ..
        "checkbox[5,7.25;long;" .. FS("Show long file paths") .. ";" ..
                meta:get_string("show_long_paths") .. "]"

    return formspec

end

local function do_search(player, meta, pattern)

    -- Compile a list of paths to schematics that match the specified pattern
    -- Use the list to update metadata, ready for a new formspec to be displayed

    -- Strip whitespace from "pattern", in case the user has copy-pasted it from the "Matching
    --      schematics" list
    pattern = unilib.utils.strip_whitespace(pattern)

    -- Get lists of all schematics, both short and full paths to the schematic file
    local short_schem_table = {}
    local long_schem_table = {}
    if pattern ~= "" then

        for _, folder in ipairs(folder_list) do

            local short_path_list = core.get_dir_list(folder, false)
            for _, short_path in ipairs(short_path_list) do

                if string.match(short_path, "^.+(%..+)$") == ".mts" and
                        string.match(short_path, pattern) then

                    short_schem_table[short_path] = true
                    long_schem_table[folder .. "/" .. short_path] = true

                end

            end

        end

    end

    -- Sort the list for display
    local short_sorted_list = unilib.utils.sort_table(short_schem_table)
    local long_sorted_list = unilib.utils.sort_table(long_schem_table)
    -- (Both lists have the same number of members)
    local sorted_count = #short_sorted_list

    -- Concatenate every schematic path into a single string, with paths separated by a newline
    --      character
    local short_schem_listing = ""
    for _, short_path in ipairs(short_sorted_list) do

        if short_schem_listing == "" then
            short_schem_listing = short_path
        else
            short_schem_listing = short_schem_listing .. "\n" .. short_path
        end

    end

    local long_schem_listing = ""
    for _, long_path in ipairs(long_sorted_list) do

        if long_schem_listing == "" then
            long_schem_listing = long_path
        else
            long_schem_listing = long_schem_listing .. "\n" .. long_path
        end

    end

    -- Update metadata
    meta:set_string("short_schem_listing", short_schem_listing)
    meta:set_string("long_schem_listing", long_schem_listing)
    meta:set_int("schem_count", sorted_count)
    if sorted_count > 0 then

        if meta:get_string("use_reverse_cycle") == "true" then
            meta:set_int("schem_index", sorted_count)
        else
            meta:set_int("schem_index", 1)
        end

    else

        meta:set_int("schem_index", 0)

    end

end

local function on_use(itemstack, user, pointed_thing)

    -- Handle left-clicks while wielding the tool, which places a schematic in the world (if one is
    --      due to be placed)

    if user == nil or pointed_thing == nil then
        return nil
    end

    if pointed_thing.type ~= "node" then
        return nil
    end

    local pname = user:get_player_name()
    local meta = itemstack:get_meta()
    local short_path, long_path = get_current_schem(meta)
    if short_path == "" then

        core.chat_send_player(pname, S("Specify some schematics by right-clicking with this tool"))
        return nil

    elseif not unilib.utils.is_file(long_path) then

        core.chat_send_player(pname, S("Schematic does not exist: @1", long_path))
        return nil

    end

    -- On the first use of this tool in every session, compile a list of known bush/tree offsets,
    --      ready for when they're needed
    if not known_offset_flag then
        compile_known_offsets()
    end

    -- If required, each schematic stands on top of a column, so we can see clearly the displacement
    --      of the surface when the schematic is placed on it
    local pos = core.get_pointed_thing_position(pointed_thing, true)
    local mini_offset_table = known_offset_table[short_path]

    local column_offset = 0
    if meta:get_string("place_column") == "true" then

        column_offset = 5

        for i = 0, 3 do

            core.set_node(
                {x = pos.x, y = pos.y + i, z = pos.z}, {name = "unilib:admin_node_colour_black"}
            )

        end

        core.set_node(
            {x = pos.x, y = pos.y + 4, z = pos.z}, {name = "unilib:admin_node_colour_white"}
        )

        -- If available, place a sign on the column, identifying the schematic and whether a known
        --      offset applies to it (steel signs if a known offset applies, wooden signs
        --      otherwise)
        if unilib.global.pkg_executed_table["sign_wall_steel"] ~= nil and
                unilib.global.pkg_executed_table["sign_wall_wood"] ~= nil then

            local sign_pos = {x = pos.x, y = pos.y + 2, z = pos.z - 1}
            if mini_offset_table == nil or
                    meta:get_string("use_bush_tree_offsets") == "false" then
                core.set_node(sign_pos, {name = "unilib:sign_wall_wood", param2 = 4})
            else
                core.set_node(sign_pos, {name = "unilib:sign_wall_steel", param2 = 4})
            end

            local sign_meta = core.get_meta(sign_pos)
            sign_meta:set_string("text", short_path)
            sign_meta:set_string("infotext", short_path)

        end

    end

    -- Convert the raw schematic to a Lua table, so we can read the .size of the schematic, so we
    --      can place the centre of the schematic at the clicked location (as would happen with a
    --      decoration)
    local this_schem_table = core.read_schematic(long_path, {})

    -- Place the schematic itself
    if mini_offset_table == nil or meta:get_string("use_bush_tree_offsets") == "false" then

        -- Place the schematic at its adjusted position
        core.place_schematic(
            {
                x = pos.x - math.floor(this_schem_table.size.x / 2),
                y = pos.y + column_offset,
                z = pos.z - math.floor(this_schem_table.size.z / 2),
            },
            long_path,
            "0",
            {},
            false
        )

    else

        -- Place the schematic at its adjusted position
        core.place_schematic(
            {
                x = pos.x - mini_offset_table.x,
                y = pos.y - mini_offset_table.y + column_offset,
                z = pos.z - mini_offset_table.z,
            },
            long_path,
            "0",
            {},
            false
        )

    end

    -- Show the placed schematic in chat, if required
    local schem_count = meta:get_int("schem_count")
    local schem_index = meta:get_int("schem_index")
    if meta:get_string("show_in_chat") == "true" then

        local count = "(" .. tostring(schem_index) .. "/" .. tostring(schem_count) .. ")"
        local size = "[" .. tostring(this_schem_table.size.x) .. "/" ..
                tostring(this_schem_table.size.y) .. "/" ..
                tostring(this_schem_table.size.z) .. "]"

        if mini_offset_table ~= nil then

            size = size .. " [" .. tostring(mini_offset_table.x) .. "/" ..
                    tostring(mini_offset_table.y) .. "/" ..
                    tostring(mini_offset_table.z) .. "]"

        end

        if meta:get_string("show_long_paths") == "true" then
            core.chat_send_player(pname, S("Placed schematic @1 @2: @3", count, size, long_path))
        else
            core.chat_send_player(pname, S("Placed schematic @1 @2: @3", count, size, short_path))
        end

    end

    -- Set up the next schematic. If we've reached the end of the list, go back to the beginning
    --      (and vice-versa)
    if meta:get_string("use_cycle") == "true" then

        schem_index = schem_index + 1
        if schem_index > schem_count then
            schem_index = 1
        end

        meta:set_int("schem_index", schem_index)
        user:set_wielded_item(itemstack)

    elseif meta:get_string("use_reverse_cycle") == "true" then

        schem_index = schem_index - 1
        if schem_index < 1 then
            schem_index = schem_count
        end

        meta:set_int("schem_index", schem_index)
        user:set_wielded_item(itemstack)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_tester_schematic.init()

    return {
        description = "Admin schematic tester",
        notes = "A tool for testing schematics, and in particular their positions when placed" ..
                " in the game world. Right-click while wielding the tool to show a graphical" ..
                " interface, in which you can search for unilib schematics. If your search" ..
                " matches at least one schematic, they are added to a list; you can then" ..
                " left-click with the tool on any node to place, at that position, the first" ..
                " schematic in the list. If the cycle buttons are selected, subsequent" ..
                " left-clicks will place the remainining schematics, one at a time (otherwise," ..
                " the same schematic is placed repeatedly). Schematics can be placed on a" ..
                " column, five blocks tall, to show whether the schematic is placed wholly or" ..
                " only partially above the surface. Schematics for bushes and trees are often" ..
                " used with a \"known\" offset, so that the schematic is placed at its intended" ..
                " centre (which is not necessarily the centre of the schematic); if you don't" ..
                " want that behaviour, you can deselect it. When this tool uses a \"known\"" ..
                " offset, it places a steel sign on the column (rather than a wooden one). Note" ..
                " that schematics are designed to work with different blocks of code, so a" ..
                " schematic may appear to be off-centre (especially when the schematic width" ..
                " is not an odd number). Likewise, some logs may be placed directly on top of" ..
                " the column (or surface), while others may be one block higher. If chat" ..
                " messages are enabled, you will see the size of the schematic list, the size" ..
                " of the schematic, and the \"known\" offsets (if any)",
        depends = {"admin_node_colour", "shared_maptools"},
        optional = {"sign_wall_steel", "sign_wall_wood"},
    }

end

function unilib.pkg.admin_tool_tester_schematic.exec()

    unilib.register_tool("unilib:admin_tool_tester_schematic", nil, mode, {
        -- Original to unilib
        description = unilib.utils.hint(S("Admin Schematic Tester"), S("places schematics")),
        inventory_image = "unilib_admin_tool_tester_schematic.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        -- The tester must store information, so only one can be stacked
        stack_max = 1,
        range = 20,
        tool_capabilities = unilib.pkg.shared_maptools.toolcaps_table,

        on_place = function(itemstack, placer, pointed_thing)

            -- Handle right-clicks while wielding the tool, which opens the formspec

            local meta = itemstack:get_meta()
            if meta:get_string("is_initialised") == "" then

                -- On first use, initialise metadata
                meta:set_string("is_initialised", "true")

                -- Formspec checkbuttons
                meta:set_string("use_cycle", "true")
                meta:set_string("use_reverse_cycle", "false")
                meta:set_string("show_in_chat", "false")
                meta:set_string("place_column", "true")
                meta:set_string("use_bush_tree_offsets", "true")
                meta:set_string("show_long_paths", "false")

                -- A list of (short) paths to schematics, matching the search criteria. The value is
                --      a string of paths, separated by newline characters
                meta:set_string("short_schem_listing", "")
                -- A corresponding list of full file paths to schematics
                meta:set_string("long_schem_listing", "")
                -- The number of schematics matching the search criteria
                meta:set_int("schem_count", 0)
                -- The next schematic to be placed. If one of the cycle checkbuttons is selected,
                --      this value changes every time a schematic is placed; otherwise, the same
                --      schematic is placed every time
                meta:set_int("schem_index", 0)

                placer:set_wielded_item(itemstack)

            end

            core.show_formspec(
                placer:get_player_name(),
                "unilib:formspec_admin_tool_tester_schematic",
                get_formspec(itemstack)
            )

        end,

        on_use = on_use,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- The player has interacted with our formspec
        if not formname or
                formname ~= "unilib:formspec_admin_tool_tester_schematic" or
                not fields then
            return false
        end

        local itemstack = player:get_wielded_item()
        local meta = itemstack:get_meta()
        -- When one of the checkbuttons has been toggled, we try to preserve the contents of the
        --      search box
        local preserve_search = ""

        if fields.cycle then

            meta:set_string("use_cycle", fields.cycle)
            meta:set_string("use_reverse_cycle", "false")
            preserve_search = fields.search

        elseif fields.reverse then

            meta:set_string("use_reverse_cycle", fields.reverse)
            meta:set_string("use_cycle", "false")
            preserve_search = fields.search

        elseif fields.chat then

            meta:set_string("show_in_chat", fields.chat)
            preserve_search = fields.search

        elseif fields.column then

            meta:set_string("place_column", fields.column)
            preserve_search = fields.search

        elseif fields.bushtree then

            meta:set_string("use_bush_tree_offsets", fields.bushtree)
            preserve_search = fields.search

        elseif fields.long then

            meta:set_string("show_long_paths", fields.long)
            preserve_search = fields.search

        elseif fields.showall then

            do_search(player, meta, ".*")

        elseif fields.reset then

            meta:set_string("short_schem_listing", "")
            meta:set_string("long_schem_listing", "")
            meta:set_int("schem_count", 0)
            meta:set_int("schem_index", 0)

        elseif fields.search and fields.search ~= "" then

            do_search(player, meta, fields.search)

        else

            return true

        end

        -- (Because it's a tool, metadata is lost without this line)
        player:set_wielded_item(itemstack)

        -- (Selecting one checkbox deselects the others; redraw the formspec to make that visible)
        if not fields.quit then

            core.show_formspec(
                player:get_player_name(),
                "unilib:formspec_admin_tool_tester_schematic",
                get_formspec(itemstack, preserve_search)
            )

        end

        return true

    end)

end
