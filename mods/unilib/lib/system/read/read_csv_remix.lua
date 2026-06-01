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

local function refine_value(value, constant_value)

    -- Switch a value read from a remix CSV for the corresponding value in constants.csv, when
    --      available

    if value == nil or constant_value == nil then
        return value
    else
        return constant_value
    end

end

local function register_remix_biomes(remix_name, biome_check_table)

    -- Read the remix CSV containing biomes, and update global variables

    local constants_table = unilib.global.remix_constants_table[remix_name]

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

                    -- Update local variables
                    biome_check_table[biome_name] = ""
                    mini_check_table[biome_name] = ""
                    biome_count = biome_count + 1

                    -- Update global variables, replacing any constants
                    -- N.B. "biome_name" cannot be replaced with a constant value
                    table.insert(unilib.global.biome_csv_setup_list, {
                        -- (original to unilib)
                        remix_name = remix_name,

                        -- .name
                        biome_name = biome_name,
                        -- (original to unilib)
                        description = refine_value(description, constants_table[description]),
                        -- (original biome name ignored, if specified)
                        -- .node_dust
                        dust = refine_value(dust, constants_table[dust]),
                        -- .node_top, .depth_top
                        top_str = refine_value(top_str, constants_table[top_str]),
                        -- .node_filler, .depth_filler
                        fill_str = refine_value(fill_str, constants_table[fill_str]),
                        -- .node_stone
                        stone = refine_value(stone, constants_table[stone]),
                        -- .node_water_top, .depth_water_top
                        water_top_str = refine_value(water_top_str, constants_table[water_top_str]),
                        -- .node_water
                        water = refine_value(water, constants_table[water]),
                        -- .node_river_water
                        river = refine_value(river, constants_table[river]),
                        -- .node_riverbed, .depth_riverbed
                        riverbed_str = refine_value(riverbed_str, constants_table[riverbed_str]),
                        -- .node_cave_liquid
                        cave_liquid = refine_value(cave_liquid, constants_table[cave_liquid]),
                        -- .node_dungeon
                        dungeon = refine_value(dungeon, constants_table[dungeon]),
                        -- .node_dungeon_alt
                        dungeon_alt = refine_value(dungeon_alt, constants_table[dungeon_alt]),
                        -- .node_dungeon_stair
                        dungeon_stair = refine_value(dungeon_stair, constants_table[dungeon_stair]),
                        -- .y_max
                        y_max = refine_value(y_max, constants_table[y_max]),
                        -- .y_min
                        y_min = refine_value(y_min, constants_table[y_min]),
                        -- (.max_pos and .min_pos are not supported)
                        -- .vertical_blend
                        blend = refine_value(blend, constants_table[blend]),
                        -- .heat_point
                        heat = refine_value(heat, constants_table[heat]),
                        -- .humidity_point
                        humidity = refine_value(humidity, constants_table[humidity]),
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

local function register_remix_constants(remix_name)

    -- Read the remix CSV containing constants, and store the data in a global variable, ready for
    --      anything that needs it
    -- Note that any constants specified by a constants.csv file should probably be in CAPITAL
    --      LETTERS, like the default constants listed below

    local constants_path = unilib.global.remix_dir_table[remix_name] .. "/constants.csv"
    -- Get default height constants (which can be overriden by the CSV file, if required)
    local constants_table = unilib.utils.get_height_constants()

    -- Read general constants
    if unilib.utils.is_file(constants_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter
            -- "value" is now optional; before v1.2.0, it was expected to contain at least one digit
            local key, value = unpack(csv_table)
            if key ~= nil and value ~= nil then

                if not string.find(key, "%a") then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_constants():" ..
                                " Invalid general constant in remix",
                        constants_path,
                        i
                    )

                --[[
                elseif not string.find(value, "[%d]") then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_constants():" ..
                                " Invalid general constant value in remix",
                        constants_path,
                        i
                    )
                ]]--

                else

                    constants_table[key] = unilib.utils.strip_whitespace(value)

                end

            end

        end

    end

    -- Update global variables
    unilib.global.remix_constants_table[remix_name] = constants_table

end

local function register_remix_decorations(remix_name)

    -- Read the remix CSV containing decorations, and update global variables

    local constants_table = unilib.global.remix_constants_table[remix_name]

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

                    -- Update local variables
                    deco_count = deco_count + 1

                    -- Update global variables, replacing any constants. For acceptable values, see
                    --      the comments in ../lib/system/global/global_variables.lua
                    -- N.B. "deco_name" and "deco_type" cannot be replaced with constant values
                    table.insert(unilib.global.deco_csv_setup_list, {
                        remix_name = remix_name,            -- (original to unilib)

                        deco_name = deco_name,
                        deco_type = deco_type,
                        biomes = refine_value(biomes, constants_table[biomes]),
                        fill_ratio = refine_value(fill_ratio, constants_table[fill_ratio]),
                        flags = refine_value(flags, constants_table[flags]),
                        height_max = refine_value(height_max, constants_table[height_max]),
                        num_spawn_by = refine_value(num_spawn_by, constants_table[num_spawn_by]),
                        place_on = refine_value(place_on, constants_table[place_on]),
                        sidelen = refine_value(sidelen, constants_table[sidelen]),
                        spawn_by = refine_value(spawn_by, constants_table[spawn_by]),
                        y_max = refine_value(y_max, constants_table[y_max]),
                        y_min = refine_value(y_min, constants_table[y_min]),
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

local function register_remix_labels(remix_name)

    -- Read the remix CSV containing remix labels. A remix label is a type of "category" for
    --      remixes, multiple remixes can share the same "category"

    local labels_path = unilib.global.remix_dir_table[remix_name] .. "/labels.csv"
    local labels_table = {}

    if unilib.utils.is_file(labels_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(labels_path)) do

            -- "label" is expected to contain at least one letter
            local label = unpack(csv_table)
            if label ~= nil then

                if not string.find(label, "%a") then

                    unilib.utils.show_warning(
                        "../lib/system/read/read_csv_remix.lua, register_remix_labels():" ..
                                " Invalid remix label",
                        labels_path,
                        i
                    )

                else

                    -- Eliminate duplicates
                    labels_table[label] = true

                end

            end

        end

    end

    -- Update global variables
    if not unilib.utils.is_table_empty(labels_table) then
        unilib.global.remix_label_table[remix_name] = labels_table
    end

end

local function register_remix_ores(remix_name)

    -- Read the remix CSVs containing ores, and update global variables

    local constants_table = unilib.global.remix_constants_table[remix_name]

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

                    -- Update local variables
                    ore_count = ore_count + 1

                    -- Update global variables, replacing any constants. For acceptable values, see
                    --      the comments in ../lib/system/global/global_variables.lua
                    -- N.B. "ore_type" cannot be replaced with a constant value
                    table.insert(unilib.global.ore_csv_setup_list, {
                        remix_name = remix_name,            -- (original to unilib)
                        ore_type = ore_type,                -- (original to unilib)

                        -- (All ore types)
                        ore = refine_value(ore, constants_table[ore]),
                        ore_param2 = refine_value(ore_param2, constants_table[ore_param2]),
                        wherein = refine_value(wherein, constants_table[wherein]),
                        clust_scarcity =
                                refine_value(clust_scarcity, constants_table[clust_scarcity]),
                        clust_num_ores =
                                refine_value(clust_num_ores, constants_table[clust_num_ores]),
                        clust_size = refine_value(clust_size, constants_table[clust_size]),
                        y_max = refine_value(y_max, constants_table[y_max]),
                        y_min = refine_value(y_min, constants_table[y_min]),
                        flags = refine_value(flags, constants_table[flags]),
                        noise_threshold =
                                refine_value(noise_threshold, constants_table[noise_threshold]),
                        np_offset = refine_value(np_offset, constants_table[np_offset]),
                        np_scale = refine_value(np_scale, constants_table[np_scale]),
                        np_spread = refine_value(np_spread, constants_table[np_spread]),
                        np_seed = refine_value(np_seed, constants_table[np_seed]),
                        np_octaves = refine_value(np_octaves, constants_table[np_octaves]),
                        np_persist = refine_value(np_persist, constants_table[np_persist]),
                        biomes = refine_value(biomes, constants_table[biomes]),
                        -- ("sheet" only)
                        column_height_max =
                                refine_value(column_height_max, constants_table[column_height_max]),
                        column_height_min =
                                refine_value(column_height_min, constants_table[column_height_min]),
                        column_midpoint_factor = refine_value(
                            column_midpoint_factor, constants_table[column_midpoint_factor]
                        ),
                        -- ("puff" only)
                        nppt_offset = refine_value(nppt_offset, constants_table[nppt_offset]),
                        nppt_scale = refine_value(nppt_scale, constants_table[nppt_scale]),
                        nppt_spread = refine_value(nppt_spread, constants_table[nppt_spread]),
                        nppt_seed = refine_value(nppt_seed, constants_table[nppt_seed]),
                        nppt_octaves = refine_value(nppt_octaves, constants_table[nppt_octaves]),
                        nppt_persist = refine_value(nppt_persist, constants_table[nppt_persist]),
                        nppb_offset = refine_value(nppb_offset, constants_table[nppb_offset]),
                        nppb_scale = refine_value(nppb_scale, constants_table[nppb_scale]),
                        nppb_spread = refine_value(nppb_spread, constants_table[nppb_spread]),
                        nppb_seed = refine_value(nppb_seed, constants_table[nppb_seed]),
                        nppb_octaves = refine_value(nppb_octaves, constants_table[nppb_octaves]),
                        nppb_persist = refine_value(nppb_persist, constants_table[nppb_persist]),
                        -- ("vein" only)
                        random_factor = refine_value(random_factor, constants_table[random_factor]),
                        -- ("stratum" only)
                        npst_offset = refine_value(npst_offset, constants_table[npst_offset]),
                        npst_scale = refine_value(npst_scale, constants_table[npst_scale]),
                        npst_spread = refine_value(npst_spread, constants_table[npst_spread]),
                        npst_seed = refine_value(npst_seed, constants_table[npst_seed]),
                        npst_octaves = refine_value(npst_octaves, constants_table[npst_octaves]),
                        npst_persist = refine_value(npst_persist, constants_table[npst_persist]),
                        stratum_thickness =
                                refine_value(stratum_thickness, constants_table[stratum_thickness]),
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

local function register_remix_files()

    -- Read the standard optional CSVs for each remix:
    --      biomes.csv
    --      constants.csv
    --      decorations.csv
    --      labels.csv
    --      ore_blob.csv
    --      ore_puff.csv
    --      ore_scatter.csv
    --      ore_sheet.csv
    --      ore_stratum.csv
    --      ore_vein.csv
    -- (Note that the only standard compulsory CSV, packages.csv, is read elsewhere)
    --
    -- Compile an ordered list of biomes/decorations/ores that must be defined, ignoring any
    --      duplicates. They, along with data read from labels.csv, are stored in global variables,
    --      ready for use

    local biome_check_table = {}

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        register_remix_labels(remix_name)
        register_remix_constants(remix_name)

        biome_check_table = register_remix_biomes(remix_name, biome_check_table)
        register_remix_decorations(remix_name)
        register_remix_ores(remix_name)

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Register CSV files provided by individual remixes
register_remix_files()
