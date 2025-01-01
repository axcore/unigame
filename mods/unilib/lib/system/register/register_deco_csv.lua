---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_deco_csv.lua
--      Register decorations from CSV
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- When reading decorations from CSV, show warnings if nodes don't exist
local deco_check_table = {}

---------------------------------------------------------------------------------------------------
-- Register decorations from CSV
---------------------------------------------------------------------------------------------------

function unilib.register._register_decoration_from_csv(data_table, deco_name, deco_type)

    -- Original to unilib
    -- The file decorations.csv in the remix folder defines a list of decorations and their
    --      properties
    -- Convert data loaded from the CSV into the format expected by
    --      unilib.register_decoration_generic(), then call that function
    --
    -- Args:
    --      data_table (table): Table created by ../lib/system/read/read_csv_remix.lua, defining the
    --          properties of a single decoration. For the table format, see the comments in
    --          ../lib/system/global/global_variables.lua
    --
    -- Optional args:
    --      deco_name, deco_type (str): Specified when this function calls itself recursively;
    --          overrides the values of the keys "deco_name" and "deco_type" in "data_table"

    local def_table = {}

    -- If function not called recursively, use actual values from "data_table"
    if deco_name == nil then
        deco_name = data_table.deco_name
    end

    if deco_type == nil then
        deco_type = data_table.deco_type
    end

    if deco_type == "simple" then

        -- If .deco_name is a list of items, use the first one to give the decoration a unique
        --      name
        local deco_name_list = unilib.utils.split_string_by_whitespace(deco_name)

        def_table.name = unilib.utils.get_unique_deco_name(deco_name_list[1])
        def_table.deco_type = "simple"

        if #deco_name_list == 1 then
            def_table.decoration = deco_name_list[1]
        else
            def_table.decoration = deco_name_list
        end

        if def_table.height_max ~= "" then
            def_table.height_max = tonumber(data_table.height_max)
        end

    elseif deco_type == "schematic" or deco_type == "schematic_no_rotate" then

        -- In Minetest v5.9.1 (and earlier), calls to core.register_decoration() can specify
        --      multiple nodes, but not multiple schematics
        -- Presumably this will be implemented in the future; in the meantime, we allow
        --      decorations.csv to specify multiple schematics on the same line
        if string.find(deco_name, "%s") then

            -- Call this function recursively for each separate schematic
            for _, schem_name in ipairs(unilib.utils.split_string_by_whitespace(deco_name)) do
                unilib.register_decoration_from_csv(data_table, schem_name, "schematic")
            end

            return

        end

        -- From here on, "deco_name" is the name of a single schematic
        def_table.name = unilib.utils.get_unique_deco_name(deco_name)
        def_table.deco_type = "schematic"
        def_table.schematic = unilib.core.path_mod .. "/mts/" .. deco_name .. ".mts"

        if data_table.flags == "" then
            def_table.flags = "place_center_x, place_center_z"
        else
            def_table.flags = unilib.register.parse_flags(data_table.flags)
        end

        if deco_type == "schematic" then
            def_table.rotation = "random"
        else
            def_table.rotation = "0"
        end

        if data_table.sidelen == "" then
            def_table.sidelen = 16
        else
            def_table.sidelen = tonumber(data_table.sidelen)
        end

        -- Apply the y offset specified by the generic definition that uses the same schematic (if
        --      any)
        if unilib.global.deco_schem_offset_table[def_table.schematic] ~= nil then
            def_table.place_offset_y = unilib.global.deco_schem_offset_table[def_table.schematic]
        end

    elseif deco_type == "treelog" then

        -- .deco_name can contain any number of items, separated by whitespace: either schematic
        --      names (for trees) or node names (used to produce the corresponding logs)
        if string.find(deco_name, "%s") then

            -- Call this function recursively for each separate schematic/node name
            for _, item_name in ipairs(unilib.utils.split_string_by_whitespace(deco_name)) do

                if not string.find(item_name, ":") then
                    unilib.register_decoration_from_csv(data_table, item_name, "schematic")
                else
                    unilib.register_decoration_from_csv(data_table, item_name, "treelog")
                end

            end

            return

        end

        if unilib.setting.tree_to_log_factor == 0 then

            -- Treelogs have been disabled
            return

        else

            --[[
            -- Create the log schematic
            def_table.name = unilib.utils.get_unique_deco_name(deco_name)
            def_table.deco_type = "schematic"
            def_table.schematic = unilib.core.path_mod .. "/mts/unilib_tree_generic_log.mts"

            if data_table.flags == "" then
                def_table.flags = "place_center_x"
            else
                def_table.flags = unilib.register.parse_flags(data_table.flags)
            end

            def_table.place_offset_y = 1
            def_table.rotation = "random"

            if data_table.sidelen == "" then
                def_table.sidelen = 16
            else
                def_table.sidelen = tonumber(data_table.sidelen)
            end

            -- The generic log schematic uses apple tree trunks; "deco_name" specifies the
            --      replacement trunk
            def_table.replacements = {["unilib:tree_apple_trunk"] = deco_name}
            ]]--

            -- Create the log schematic
            -- Because Minetest caches both the schematic and its .replacements field in memory,
            --      the code above generates logs of a single tree type throughout the world
            -- Until that problem is resolved, we're forced to generated our own schematics in Lua
            def_table.name = unilib.utils.get_unique_deco_name(deco_name)
            def_table.deco_type = "schematic"
            def_table.schematic = unilib.trees.generate_treelog_schematic(deco_name)

            if data_table.flags == "" then
                def_table.flags = "place_center_x"
            else
                def_table.flags = unilib.register.parse_flags(data_table.flags)
            end

            def_table.place_offset_y = 1
            def_table.rotation = "random"

            if data_table.sidelen == "" then
                def_table.sidelen = 16
            else
                def_table.sidelen = tonumber(data_table.sidelen)
            end

        end

    else

        -- Failsafe, in case some code other than that in read_csv.lua has inserted data into
        --      unilib.global.deco_csv_setup_list()
        return

    end

    if data_table.biomes ~= "" then
        def_table.biomes = unilib.utils.split_string_by_whitespace(data_table.biomes, true)
    end

    if data_table.fill_ratio ~= "" then

        if deco_type ~= "treelog" then

            def_table.fill_ratio = tonumber(data_table.fill_ratio)

        else

            def_table.fill_ratio =
                    tonumber(data_table.fill_ratio) * unilib.setting.tree_to_log_factor

        end

    end

    if data_table.num_spawn_by ~= "" then
        def_table.num_spawn_by = tonumber(data_table.num_spawn_by)
    end

    if data_table.place_on ~= "" then
        def_table.place_on = unilib.utils.split_string_by_whitespace(data_table.place_on, true)
    end

    if data_table.spawn_by ~= "" then
        def_table.spawn_by = unilib.utils.split_string_by_whitespace(data_table.spawn_by, true)
    end

    if data_table.y_max ~= "" then
        def_table.y_max = tonumber(data_table.y_max)
    end

    if data_table.y_min ~= "" then
        def_table.y_min = tonumber(data_table.y_min)
    end

    -- Check for valid heights, if required
    if unilib.setting.debug_check_heights_flag and
            not unilib.utils.check_heights(def_table.y_max, def_table.y_min) then

        unilib.utils.show_warning(
            "unilib.register_decoration_from_csv(): Invalid height values in decoration" ..
                    " registration",
            def_table.name,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- Check for missing nodes
    for _, string_or_list in pairs({
        def_table.decoration,
        def_table.place_on,
        def_table.spawn_by,
    }) do

        if def_table.deco_type == "simple" then

            for _, full_name in pairs(unilib.utils.convert_to_list(string_or_list)) do

                -- During all calls to this function, show only one warning for each missing node
                if full_name ~= nil and deco_check_table[full_name] == nil then

                    if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

                        deco_check_table[full_name] = true
                        unilib.utils.show_warning(
                            "unilib.register_decoration_from_csv(): Unrecognised node in CSV file",
                            full_name
                        )

                    end

                end

            end

        end

    end

    -- When biome showcase mode is enabled, all decorations must spawn at all heights
    if unilib.setting.debug_biome_showcase_flag then

        def_table.y_max = unilib.constant.y_max
        def_table.y_min = unilib.constant.y_min

    end

    -- If biome filters are enabled, and apply to all biomes specified by the decoration, then the
    --      decoration is not viable, and must not be registered
    def_table = unilib.register.check_biomes_in_decoration(def_table)
    if def_table == nil then
        return
    end

    -- The decoration definition is now ready to be registered with the engine
--  core.register_decoration(def_table)
    table.insert(unilib.global.deco_csv_final_list, def_table)
    if def_table.name ~= nil then
        unilib.global.deco_name_check_table[def_table.name] = true
    end

end
