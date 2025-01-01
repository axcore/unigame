---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_biome.lua
--      Register biomes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- x/z coordinates for a grid, when biome showcase mode is enabled
local biome_showcase_x = 0
local biome_showcase_z = 0
local biome_showcase_count = 0

---------------------------------------------------------------------------------------------------
-- Register biomes
---------------------------------------------------------------------------------------------------

function unilib.register._register_biome(def_table, csv_flag)

    -- Original to unilib
    -- Register the biome with Minetest and, after some checks, updates global variables
    --
    -- Args:
    --      def_table (table): Usual definition table for the biomes. Note that "def_table" must
    --          include, at the very least, a .name property
    --
    -- Optional args:
    --      csv_flag (bool): true when called by unilib.register_biome_from_csv()

    -- If biome showcase mode is specified, place each biome in a zone (50x50 blocks by default), in
    --      a grid near the centre of the world
    if unilib.setting.debug_biome_showcase_flag then

        if unilib.setting.debug_biome_showcase_exclude_flag and (
            (
                def_table.y_max ~= nil and
                def_table.y_max < unilib.setting.debug_biome_showcase_min_height
            ) or (
                def_table.y_min ~= nil and
                def_table.y_min > unilib.setting.debug_biome_showcase_max_height
            )
        ) then
            return
        end

        def_table.y_max = nil
        def_table.y_min = nil
        def_table.heat_point = 50
        def_table.humidity_point = 50

        local x_pos = unilib.setting.debug_biome_showcase_size * biome_showcase_x
        local z_pos = unilib.setting.debug_biome_showcase_size * biome_showcase_z
        biome_showcase_x = biome_showcase_x + 1
        if biome_showcase_x >= 10 then

            biome_showcase_x = 0
            biome_showcase_z = biome_showcase_z + 1

        end

        def_table.max_pos = {
            x = (x_pos + (unilib.setting.debug_biome_showcase_size - 1)),
            y = unilib.constant.y_max,
            z = (z_pos + (unilib.setting.debug_biome_showcase_size - 1)),
        }

        def_table.min_pos = {x = (x_pos + 1), y = unilib.constant.y_min, z = (z_pos + 1)}

        biome_showcase_count = biome_showcase_count + 1
        unilib.utils.show_msg("Biome showcase " .. biome_showcase_count .. ": " .. def_table.name)

    -- If the Minetest setting is specified, force a single biome across the whole world
    elseif unilib.setting.debug_forced_biome ~= nil and unilib.setting.debug_forced_biome ~= "" then

        if def_table.name ~= unilib.setting.debug_forced_biome then

            return

        else

            def_table.y_max = unilib.constant.y_max
            def_table.y_min = unilib.constant.y_min
            def_table.heat_point = 50
            def_table.humidity_point = 50

        end

    end

    -- Apply the biome filter, if specified
    if unilib.setting.debug_biome_filter ~= nil and
            unilib.setting.debug_biome_filter ~= "" and
            not string.find(def_table.name, unilib.setting.debug_biome_filter) then
        return
    end

    -- Basic checks
    if def_table.name == nil or def_table.name == "" then

        unilib.utils.show_error(
            "unilib.register_biome(): Invalid biome registration (missing name)"
        )

        return

    elseif unilib.global.biome_info_table[def_table.name] ~= nil then

        unilib.utils.show_warning(
            "unilib.register_biome(): Duplicate biome registration", def_table.name
        )

    elseif unilib.setting.debug_check_heights_flag and
            not unilib.utils.check_heights(def_table.y_max, def_table.y_min) then

        unilib.utils.show_warning(
            "unilib.register_biome(): Invalid height values in biome registration",
            def_table.name,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- The biome definition is now ready to be registered with the engine
--  core.register_biome(def_table)
    if csv_flag then
        table.insert(unilib.global.biome_csv_final_list, def_table)
    else
        table.insert(unilib.global.biome_other_final_list, def_table)
    end

    if def_table.name ~= nil then
        unilib.global.biome_name_check_table[def_table.name] = true
    end

    -- Register a new biome in unilib's biome registry, using default values for any property that
    --      was not specified in the function call
    local data_table = {}

    data_table.biome_name = def_table.name
    data_table.description = def_table.description or def_table.name

    if def_table.y_max == nil then
        data_table.y_max = unilib.constant.y_max
    else
        data_table.y_max = def_table.y_max
    end

    if def_table.y_min == nil then
        data_table.y_min = unilib.constant.y_min
    else
        data_table.y_min = def_table.y_min
    end

    if def_table.heat_point == nil then
        data_table.heat_point = 50
    else
        data_table.heat_point = def_table.heat_point
    end

    if def_table.humidity_point == nil then
        data_table.humidity_point = 50
    else
        data_table.humidity_point = def_table.humidity_point
    end

    if def_table.node_top ~= nil then
        data_table.place_on = def_table.node_top
    else
        data_table.place_on = def_table.node_stone
    end

    unilib.global.biome_info_table[def_table.name] = data_table

end
