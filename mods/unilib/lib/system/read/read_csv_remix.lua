---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_remix.lua
--      Register CSV files provided by individual remixes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_remix_constants(remix_name)

    -- Read the remix CSV containing environmental constants, and return the data as a table, ready
    --      for use as an argument in other function calls
    -- Note that any constants specified by a constants.csv file should probably be in CAPITAL
    --      LETTERS, like the default constants listed below

    local constants_path = unilib.global.remix_dir_table[remix_name] .. "/constants.csv"
    -- Get default height constants (which can be overriden by the CSV file, if required)
    local constants_table = unilib.utils.get_height_constants()

    -- Read environment constants
    if unilib.utils.is_file(constants_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one digit
            local key, value = unpack(csv_table)
            if key ~= nil and value ~= nil then

                if not string.find(key, "%a") then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_constants():" ..
                                " Invalid environment constant in remix",
                        constants_path,
                        i
                    )

                elseif not string.find(value, "[%d]") then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_constants():" ..
                                " Invalid environment constant value in remix",
                        constants_path,
                        i
                    )

                else

                    constants_table[key] = value

                end

            end

        end

    end

    return constants_table

end

local function register_remix_biomes(remix_name, constants_table, biome_check_table)

    -- Read the remix CSV containing biomes, and update global variables

    local biomes_path = unilib.global.remix_dir_table[remix_name] .. "/biomes.csv"
    local biome_count = 0
    local mini_check_table = {}
    local check_warning_flag = false

    if unilib.utils.is_file(biomes_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(biomes_path)) do

            local biome_name, description, orig_name, dust, top_str, fill_str, stone, water_top_str,
                    water, river, riverbed_str, cave_liquid, dungeon, dungeon_alt, dungeon_stair,
                    y_max, y_min, blend, heat, humidity, check = unpack(csv_table)

            if biome_name ~= nil and string.find(biome_name, "%a") then

                if mini_check_table[biome_name] ~= nil then

                    if unilib.setting.show_csv_duplicate_flag  then

                        unilib.utils.show_warning(
                            "../lib/system/read/read_csv_remix.lua, register_remix_biomes():" ..
                                    " Duplicate biome table in remix",
                            biomes_path,
                            i
                        )

                    end

                elseif biome_check_table[biome_name] ~= nil then

                    if unilib.setting.show_csv_duplicate_flag  then

                        unilib.utils.show_warning(
                            "../lib/system/read/read_csv_remix.lua, register_remix_biomes():" ..
                                    " Biome table already specified by another remix",
                            biomes_path,
                            i
                        )

                    end

                else

                    -- Replace constant values
                    if y_max ~= nil and constants_table[y_max] ~= nil then
                        y_max = constants_table[y_max]
                    end

                    if y_min ~= nil and constants_table[y_min] ~= nil then
                        y_min = constants_table[y_min]
                    end

                    if blend ~= nil and constants_table[blend] ~= nil then
                        blend = constants_table[blend]
                    end

                    if heat ~= nil and constants_table[heat] ~= nil then
                        heat = constants_table[heat]
                    end

                    if humidity ~= nil and constants_table[humidity] ~= nil then
                        humidity = constants_table[humidity]
                    end

                    -- Update local variables
                    biome_check_table[biome_name] = ""
                    mini_check_table[biome_name] = ""
                    biome_count = biome_count + 1
                    -- Update global variables
                    table.insert(unilib.global.biome_csv_setup_list, {
                        remix_name = remix_name,            -- (original to unilib)

                        biome_name = biome_name,            -- .name
                        description = description,          -- (original to unilib)
                        -- (original biome name ignored, if specified)
                        dust = dust,                        -- .node_dust
                        top_str = top_str,                  -- .node_top, .depth_top
                        fill_str = fill_str,                -- .node_filler, .depth_filler
                        stone = stone,                      -- .node_stone
                        water_top_str = water_top_str,      -- .node_water_top, .depth_water_top
                        water = water,                      -- .node_water
                        river = river,                      -- .node_river_water
                        riverbed_str = riverbed_str,        -- .node_riverbed, .depth_riverbed
                        cave_liquid = cave_liquid,          -- .node_cave_liquid
                        dungeon = dungeon,                  -- .node_dungeon
                        dungeon_alt = dungeon_alt,          -- .node_dungeon_alt
                        dungeon_stair = dungeon_stair,      -- .node_dungeon_stair
                        y_max = y_max,                      -- .y_max
                        y_min = y_min,                      -- .y_min
                        -- (.max_pos and .min_pos are not supported)
                        blend = blend,                      -- .vertical_blend
                        heat = heat,                        -- .heat_point
                        humidity = humidity,                -- .humidity_point
                    })

                end

                if not check_warning_flag and check ~= nil then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_biomes():" ..
                                " Extra columns in CSV (ignoring them)",
                        biomes_path,
                        i
                    )

                    check_warning_flag = true

                end

            end

        end

        -- Valid biome table
        unilib.global.remix_biome_count_table[remix_name] = biome_count

    end

    return biome_check_table

end

local function register_remix_decorations(remix_name, constants_table)

    -- Read the remix CSV containing decorations, and update global variables

    local deco_path = unilib.global.remix_dir_table[remix_name] .. "/decorations.csv"
    local deco_count = 0
    local check_warning_flag = false

    if unilib.utils.is_file(deco_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(deco_path)) do

            local deco_type, deco_name, y_max, y_min, biomes, place_on, spawn_by, num_spawn_by,
                fill_ratio, height_max, flags, sidelen, check = unpack(csv_table)

            if deco_type ~= nil then

                if deco_type ~= "simple" and
                        deco_type ~= "schematic" and
                        deco_type ~= "schematic_no_rotate" and
                        deco_type ~= "treelog" then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_decorations():" ..
                                " Invalid decoration type in remix",
                        deco_path,
                        i
                    )

                elseif deco_name == nil or not string.find(deco_name, "%a") then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_decorations():" ..
                                " Invalid or missing decoration name in remix",
                        deco_path,
                        i
                    )

                else

                    -- Replace constant values
                    if y_max ~= nil and constants_table[y_max] ~= nil then
                        y_max = constants_table[y_max]
                    end

                    if y_min ~= nil and constants_table[y_min] ~= nil then
                        y_min = constants_table[y_min]
                    end

                    -- Update local variables
                    deco_count = deco_count + 1
                    -- Update global variables. For acceptable values, see the comments in
                    --      global.lua
                    table.insert(unilib.global.deco_csv_setup_list, {
                        remix_name = remix_name,            -- (original to unilib)

                        deco_name = deco_name,
                        deco_type = deco_type,
                        biomes = biomes,
                        fill_ratio = fill_ratio,
                        flags = flags,
                        height_max = height_max,
                        num_spawn_by = num_spawn_by,
                        place_on = place_on,
                        sidelen = sidelen,
                        spawn_by = spawn_by,
                        y_max = y_max,
                        y_min = y_min,
                    })

                end

                if not check_warning_flag and check ~= nil then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_decorations():" ..
                                " Extra columns in CSV (ignoring them)",
                        deco_path,
                        i
                    )

                    check_warning_flag = true

                end

            end

        end

        -- Valid decoration table
        unilib.global.remix_deco_count_table[remix_name] = deco_count

    end

end

local function register_remix_ores(remix_name, constants_table)

    -- Read the remix CSVs containing ores, and update global variables

    local ore_type_list = {"scatter", "sheet", "puff", "blob", "vein", "stratum"}
    local ore_path_list = {}
    local ore_count = 0

    for _, ore_type in pairs(ore_type_list) do

        local ore_path = unilib.global.remix_dir_table[remix_name] .. "/ore_" .. ore_type .. ".csv"
        local check_warning_flag = false

        if unilib.utils.is_file(ore_path) then

            for i, csv_table in ipairs(unilib.utils.read_csv(ore_path)) do

                -- (All ore types)
                local ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes
                local check
                -- ("sheet" only)
                local column_height_max, column_height_min, column_midpoint_factor
                -- ("puff" only)
                local nppt_offset, nppt_scale, nppt_spread, nppt_seed, nppt_octaves, nppt_persist,
                    nppb_offset, nppb_scale, nppb_spread, nppb_seed, nppb_octaves, nppb_persist
                -- ("vein" only)
                local random_factor
                -- ("stratum" only)
                local npst_offset, npst_scale, npst_spread, npst_seed, npst_octaves, npst_persist,
                    stratum_thickness

                if ore_type == "scatter" or ore_type == "blob" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, check = unpack(csv_table)

                elseif ore_type == "sheet" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, column_height_max, column_height_min,
                    column_midpoint_factor, check = unpack(csv_table)

                elseif ore_type == "puff" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, nppt_offset, nppt_scale, nppt_spread,
                    nppt_seed, nppt_octaves, nppt_persist, nppb_offset, nppb_scale, nppb_spread,
                    nppb_seed, nppb_octaves, nppb_persist, check = unpack(csv_table)

                elseif ore_type == "vein" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, random_factor, check = unpack(csv_table)

                elseif ore_type == "stratum" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, npst_offset, npst_scale, npst_spread,
                    npst_seed, npst_octaves, npst_persist, stratum_thickness, check =
                    unpack(csv_table)

                end

                if ore ~= nil and string.find(ore, "%a") then

                    -- Replace constant values
                    if y_max ~= nil and constants_table[y_max] ~= nil then
                        y_max = constants_table[y_max]
                    end

                    if y_min ~= nil and constants_table[y_min] ~= nil then
                        y_min = constants_table[y_min]
                    end

                    -- Update local variables
                    ore_count = ore_count + 1
                    -- Update global variables. For acceptable values, see the comments in
                    --      global.lua
                    table.insert(unilib.global.ore_csv_setup_list, {
                        remix_name = remix_name,            -- (original to unilib)
                        ore_type = ore_type,                -- (original to unilib)

                        -- (All ore types)
                        ore = ore,
                        ore_param2 = ore_param2,
                        wherein = wherein,
                        clust_scarcity = clust_scarcity,
                        clust_num_ores = clust_num_ores,
                        clust_size = clust_size,
                        y_max = y_max,
                        y_min = y_min,
                        flags = flags,
                        noise_threshold = noise_threshold,
                        np_offset = np_offset,
                        np_scale = np_scale,
                        np_spread = np_spread,
                        np_seed = np_seed,
                        np_octaves = np_octaves,
                        np_persist = np_persist,
                        biomes = biomes,
                        -- ("sheet" only)
                        column_height_max = column_height_max,
                        column_height_min = column_height_min,
                        column_midpoint_factor = column_midpoint_factor,
                        -- ("puff" only)
                        nppt_offset = nppt_offset,
                        nppt_scale = nppt_scale,
                        nppt_spread = nppt_spread,
                        nppt_seed = nppt_seed,
                        nppt_octaves = nppt_octaves,
                        nppt_persist = nppt_persist,
                        nppb_offset = nppb_offset,
                        nppb_scale = nppb_scale,
                        nppb_spread = nppb_spread,
                        nppb_seed = nppb_seed,
                        nppb_octaves = nppb_octaves,
                        nppb_persist = nppb_persist,
                        -- ("vein" only)
                        random_factor = random_factor,
                        -- ("stratum" only)
                        npst_offset = npst_offset,
                        npst_scale = npst_scale,
                        npst_spread = npst_spread,
                        npst_seed = npst_seed,
                        npst_octaves = npst_octaves,
                        npst_persist = npst_persist,
                        stratum_thickness = stratum_thickness,
                    })

                end

                if not check_warning_flag and check ~= nil then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_ores():" ..
                                " Extra columns in CSV (ignoring them)",
                        ore_path,
                        i
                    )

                    check_warning_flag = true

                end

            end

        end

    end

    if ore_count > 0 then

        -- Valid ore table(s)
        if unilib.global.remix_ore_count_table[remix_name] == nil then

            unilib.global.remix_ore_count_table[remix_name] = ore_count

        else

            unilib.global.remix_ore_count_table[remix_name] =
                    unilib.global.remix_ore_count_table[remix_name] + ore_count

        end

    end

end

local function register_remix_other()

    -- Read the optional CSVs for each remix
    -- Compile an ordered list of biomes/decorations/ores that must be defined, ignoring any
    --      duplicates

    local biome_check_table = {}

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        local constants_table = register_remix_constants(remix_name)

        biome_check_table = register_remix_biomes(remix_name, constants_table, biome_check_table)

        register_remix_decorations(remix_name, constants_table)
        register_remix_ores(remix_name, constants_table)

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Register CSV files provided by individual remixes
register_remix_other()
