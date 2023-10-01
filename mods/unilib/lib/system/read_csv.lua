---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv.lua
--      Read information about source/imported mods from CSV files in /csv/mods
--      Read information about one or more remixes from CSV files in /csv/remixes
--      In case of a fatal error, reset global variables set by code in this file (which prevents
--          any packages from being imported)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local fatal_error_flag = false

local remix_check_table = {}
local pkg_check_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_source_mods()

    local source_path = unilib.path_mod .. "/csv/mods/source.csv"

    if not unilib.is_file(source_path) then

        unilib.show_error(
            "../lib/system/read_csv, register_source_mods(): Missing CSV file", source_path
        )

        fatal_error_flag = true
        return

    end

    for i, csv_table in ipairs(unilib.read_csv(source_path)) do

        local mod_name, modpack_name, dl_date, url, author, code, media, notes = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.show_warning(
                "../lib/system/read_csv, register_source_mods(): Invalid line in CSV file",
                source_path,
                i
            )

        elseif unilib.source_mod_table[mod_name] then

            unilib.show_warning(
                "../lib/system/read_csv, register_source_mods(): Duplicate mod in CSV file" ..
                        " (ignoring)",
                source_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "default"
            data_table.mod_name = mod_name
            -- The name of the modpack, if any, e.g. "minetest_game"
            data_table.modpack_name = modpack_name
            -- Date on which the mod was downloaded, in the form "YYYYMMDD"
            data_table.date = dl_date
            -- URL from which the mod was downloaded
            data_table.url = url
            -- The lead author(s), e.g. "celeron55/Perttu Ahola"
            data_table.author = author
            -- The code licence, e.g. "LGPL 2.1"
            data_table.code = code
            -- The media licence, e.g. "CC BY-SA 3.0"
            data_table.media = media
            -- A brief summary of what has been imported
            data_table.notes = notes

            unilib.source_mod_table[mod_name] = data_table

        end

    end

end

local function register_imported_mods()

    local imported_path = unilib.path_mod .. "/csv/mods/imported.csv"

    if not unilib.is_file(imported_path) then

        unilib.show_error(
            "../lib/system/read_csv, register_imported_mods(): Missing CSV file", imported_path
        )

        fatal_error_flag = true
        return

    end

    for i, csv_table in ipairs(unilib.read_csv(imported_path)) do

        local mod_name, detect_mode, replace_mode, notes = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.show_warning(
                "../lib/system/read_csv, register_imported_mods(): Invalid line in CSV file",
                imported_path,
                i
            )

        elseif unilib.imported_mod_table[mod_name] then

            unilib.show_warning(
                "../lib/system/read_csv, register_imported_mods(): Duplicate mod in CSV file" ..
                        " (ignoring)",
                imported_path,
                i
            )

        elseif detect_mode ~= "detect" and detect_mode ~= "ignore" then

            unilib.show_warning(
                "../lib/system/read_csv, register_imported_mods(): Invalid detect mode in" ..
                        " CSV file (should be \"detect\" or \"ignore\") (ignoring)",
                imported_path,
                i
            )

        elseif replace_mode ~= "add" and replace_mode ~= "defer" and
                replace_mode ~= "replace" and replace_mode ~= "hide" then

            unilib.show_warning(
                "../lib/system/read_csv, register_imported_mods(): Invalid replace mode in" ..
                        " CSV file (should be \"add\", \"defer\", \"replace\" or \"hide\")",
                imported_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "default"
            data_table.mod_name = mod_name
            -- Mod's detect mode, "detect" or "ignore"
            data_table.detect_mode = detect_mode

            -- Mod's replace mode, "defer", "add", "replace" or "hide"
            if unilib.force_replace_flag and mod_name ~= "unilib" then

                -- If the Minetest setting is set, override the mod's replace mode. This never
                --      applies to any packages whose "source" mod is unilib
                data_table.replace_mode = "replace"
                data_table.add_mode = "replace"

            else

                data_table.replace_mode = replace_mode
                data_table.add_mode = replace_mode

            end

            -- true if Minetest has already loaded the mod, false if not (or if mod detection has
            --      not been enabled)
            if detect_mode == "detect" and minetest.get_modpath(mod_name) then

                data_table.loaded_flag = true

            else

                data_table.loaded_flag = false
                if replace_mode == "replace" or replace_mode == "hide" then

                    -- (Can't replace/hide a node/craftitem if its mod is not loaded)
                    data_table.add_mode = "add"

                end

            end

            -- Set hide mode
            if data_table.add_mode == "replace" then
                data_table.hide_mode = "hide"
            else
                data_table.hide_mode = data_table.add_mode
            end

            -- Any additional importation notes
            data_table.notes = notes

            unilib.imported_mod_table[mod_name] = data_table

        end

    end

end

local function register_compatible_mods()

    local compatible_path = unilib.path_mod .. "/csv/mods/compatible.csv"

    if not unilib.is_file(compatible_path) then

        unilib.show_error(
            "../lib/system/read_csv, register_compatible_mods(): Missing CSV file",
            compatible_path
        )

        fatal_error_flag = true
        return

    end

    for i, csv_table in ipairs(unilib.read_csv(compatible_path)) do

        local mod_name, modpack_name, url, notes = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.show_warning(
                "../lib/system/read_csv, register_compatible_mods(): Invalid line in CSV file",
                compatible_path,
                i
            )

        elseif unilib.compatible_mod_table[mod_name] then

            unilib.show_warning(
                "../lib/system/read_csv, register_compatible_mods(): Duplicate mod in CSV" ..
                        " file (ignoring)",
                compatible_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "technic"
            data_table.mod_name = mod_name
            -- The name of the modpack, if any, e.g. "technic"
            data_table.modpack_name = modpack_name
            -- URL from which the mod can be downloaded
            data_table.url = url
            -- A brief summary of how unilib interacts with the mod
            data_table.notes = notes

            unilib.compatible_mod_table[mod_name] = data_table

        end

    end

end

local function register_external_mods()

    local external_path = unilib.path_mod .. "/csv/mods/external.csv"

    if not unilib.is_file(external_path) then

        unilib.show_error(
            "../lib/system/read_csv, register_external_mods(): Missing CSV file",
            external_path
        )

        fatal_error_flag = true
        return

    end

    for i, csv_table in ipairs(unilib.read_csv(external_path)) do

        local mod_name, modpack_name, url, notes = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.show_warning(
                "../lib/system/read_csv, register_external_mods(): Invalid line in CSV file",
                external_path,
                i
            )

        elseif unilib.external_mod_table[mod_name] then

            unilib.show_warning(
                "../lib/system/read_csv, register_external_mods(): Duplicate mod in CSV file" ..
                        " (ignoring)",
                external_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "technic"
            data_table.mod_name = mod_name
            -- The name of the modpack, if any, e.g. "technic"
            data_table.modpack_name = modpack_name
            -- URL from which the mod can be downloaded
            data_table.url = url
            -- A brief summary of how unilib interacts with the mod
            data_table.notes = notes

            unilib.external_mod_table[mod_name] = data_table

        end

    end

end

local function register_remix_path(remix_name)

    -- Check that the specified remix is a valid remix by checking whether its compulsory
    --      "packages.csv" file exists, or not
    -- If found, update global variables; if not found, show a warning

    local custom_path = unilib.path_mod .. "/custom/remixes/" .. remix_name
    local standard_path = unilib.path_mod .. "/csv/remixes/" .. remix_name

    if not unilib.is_file(custom_path .. "/packages.csv") and
            not unilib.is_file(standard_path .. "/packages.csv") then

        unilib.show_warning(
            "../lib/system/read_csv, register_remix_path(): Missing CSV file", standard_path
        )

    else

        table.insert(unilib.remix_list, remix_name)
        if unilib.is_file(custom_path) then
            unilib.remix_dir_table[remix_name] = custom_path
        else
            unilib.remix_dir_table[remix_name] = standard_path
        end

    end

end

local function register_remixes()

    if unilib.remix_set == nil then

        unilib.show_error(
            "../lib/system/read_csv, register_remixes(): No remix(es) specified in Minetest" ..
                    " settings"
        )

        fatal_error_flag = true
        return

    end

    -- Note that duplicate remixes are eliminated by the call to this function
    local remix_list = unilib.split_string_by_whitespace(unilib.remix_set, true)

    -- The remix names "everything" and "nothing" are reserved
    -- "everything" loads all remixes, in alphabetical order. "nothing" loads no remixes; it's
    --      the equivalent of commenting out the remix list. "nothing" cancels "everything", if both
    --      are specified
    for _, remix_name in pairs(remix_list) do

        if remix_name == "nothing" then
            return
        end

    end

    for _, remix_name in pairs(remix_list) do

        if remix_name == "everything" then

            -- Every remix has its own sub-folder, in one of two locations. User-created remixes
            --      take priority over any "standard" remixes with the same name
            local name_list = {}
            local path_table = {}

            for _, dir_name in pairs(
                minetest.get_dir_list(unilib.path_mod .. "/custom/remixes/", true)
            ) do

                table.insert(name_list, dir_name)
                path_table[dir_name] = unilib.path_mod .. "/custom/remixes/" .. dir_name

            end

            for _, dir_name in pairs(
                minetest.get_dir_list(unilib.path_mod .. "/csv/remixes/", true)
            ) do

                if path_table[dir_name] == nil then

                    table.insert(name_list, dir_name)
                    path_table[dir_name] = unilib.path_mod .. "/csv/remixes/" .. dir_name

                end

            end

            table.sort(name_list)
            for _, dir_name in pairs(name_list) do

                -- Check this is a valid remix by checking whether its compulsory "packages.csv"
                --      file exists, or not
                -- Unlike the code below, don't show any warnings; just move on to the next
                --      remix
                if unilib.is_file(path_table[dir_name] .. "/packages.csv") then

                    table.insert(unilib.remix_list, dir_name)
                    unilib.remix_dir_table[dir_name] = path_table[dir_name]

                end

            end

            return

        end

    end

    -- Register each (real) remix in turn, first checking that it is valid
    for _, remix_name in ipairs(remix_list) do
        register_remix_path(remix_name)
    end

end

local function register_remix_packages(remix_name)

    -- Read the packages.csv file for each remix
    -- Compile an ordered list of packages that must be imported, ignoring any duplicates

    -- Don't read packages from the same remix more than once
    if remix_check_table[remix_name] ~= nil then
        return
    else
        remix_check_table[remix_name] = true
    end

    if unilib.remix_dir_table[remix_name] == nil then

        -- This function was called, after "remix_name" was mentioned in another remix. Update
        --      global variables, is if "remix_name" was one of those specified in
        --      unilib.remix_set
        register_remix_path(remix_name)

    end

    local packages_path = unilib.remix_dir_table[remix_name] .. "/packages.csv"
    local pkg_count = 0

    local mini_check_list = {}
    local mini_check_table = {}

    for i, csv_table in ipairs(unilib.read_csv(packages_path)) do

        local pkg_name, orig_mod_str = unpack(csv_table)
        if pkg_name ~= nil and string.find(pkg_name, "%a") then

            if string.sub(pkg_name, 1, 1) == "@" then

                -- Call this function to read packages from the named remix, before continuing to
                --      read packages from this remix
                -- Don't read packages from the same remix more than once
                local other_remix_name = string.sub(pkg_name, 2)
                if other_remix_name ~= "" and remix_check_table[other_remix_name] == nil then
                    register_remix_packages(other_remix_name)
                end

            else

                -- Check the package file actually exists in any one of three locations. User-
                --      created packages take priority over any "standard" packages with the same
                --      name. Development packages have the lowest priority
                local custom_path = unilib.path_mod .. "/custom/packages/" .. pkg_name .. ".lua"
                local standard_path = unilib.path_mod .. "/lib/packages/" .. pkg_name .. ".lua"
                local dev_path = unilib.path_mod .. "/lib/packages/dev/" .. pkg_name .. ".lua"

                local success_flag = true

                for _, orig_mod_name in ipairs(
                    unilib.split_string_by_whitespace(orig_mod_str, true)
                ) do
                    if orig_mod_name == nil or orig_mod_name == "" then

                        unilib.show_warning(
                            "../lib/system/read_csv, register_remix_packages(): Invalid package" ..
                                    " definition in remix",
                            packages_path,
                            i
                        )

                        success_flag = false

                    elseif unilib.source_mod_table[orig_mod_name] == nil then

                        unilib.show_warning(
                            "../lib/system/read_csv, register_remix_packages(): Unrecognised" ..
                                    " source mod in remix",
                            packages_path,
                            i
                        )

                        success_flag = false

                    elseif mini_check_table[pkg_name] ~= nil then

                        unilib.show_warning(
                            "../lib/system/read_csv, register_remix_packages(): Duplicate" ..
                                    " package in remix",
                            packages_path,
                            i
                        )

                        success_flag = false

                    elseif not unilib.is_file(custom_path) and
                            not unilib.is_file(standard_path) and
                            not unilib.is_file(dev_path) then

                        unilib.show_warning(
                            "../lib/system/read_csv, register_remix_packages(): Missing package" ..
                                    " file",
                            standard_path,
                            i
                        )

                        success_flag = false

                    end

                end

                -- (If none of the warnings above were issued...)
                if success_flag then

                    table.insert(mini_check_list, pkg_name)
                    mini_check_table[pkg_name] = ""

                    if pkg_check_table[pkg_name] ~= nil then

                        if not unilib.test_equivalence_of_lists(
                            unilib.split_string_by_whitespace(orig_mod_str, true),
                            unilib.split_string_by_whitespace(
                                unilib.pkg_setup_table[pkg_name], true
                            )
                        ) then
                            unilib.show_msg(
                                "../lib/system/read_csv, register_remix_packages(): Package is" ..
                                        " specified by a different remix, and with a different" ..
                                        " set of source mods",
                                packages_path,
                                i
                            )

                        end

                        if unilib.show_pkg_remix_flag then

                            unilib.show_msg(
                                "../lib/system/read_csv, register_remix_packages(): Package" ..
                                        " already specified by another remix",
                                packages_path,
                                i
                            )

                        end

                    else

                        -- (It is permitted for the .csv file not to specify the source mod)
                        if orig_mod_str == nil then
                            orig_mod_str = ""
                        end

                        -- Update local variables
                        pkg_check_table[pkg_name] = ""
                        pkg_count = pkg_count + 1
                        -- Update global variables
                        table.insert(unilib.pkg_setup_list, pkg_name)
                        unilib.pkg_setup_table[pkg_name] = orig_mod_str

                    end

                end

            end

        end

    end

    -- Valid remix, update global variables
    unilib.remix_pkg_table[remix_name] = mini_check_list
    unilib.remix_pkg_count_table[remix_name] = pkg_count

end

local function register_remix_constants(remix_name)

    -- Read the remix CSV containing environmental constants, and return the data as a table, ready
    --      for use as an argument in other function calls
    -- Note that any constants specified by a constants.csv file should probably be in CAPITAL
    --      LETTERS, like the default constants listed below

    local constants_path = unilib.remix_dir_table[remix_name] .. "/constants.csv"
    -- Get default height constants (which can be overriden by the CSV file, if required)
    local constants_table = unilib.get_height_constants()

    -- Read environment constants
    if unilib.is_file(constants_path) then

        for i, csv_table in ipairs(unilib.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one digit
            local key, value = unpack(csv_table)
            if key ~= nil and value ~= nil then

                if not string.find(key, "%a") then

                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_constants(): Invalid environment" ..
                                " constant in remix",
                        constants_path,
                        i
                    )

                elseif not string.find(value, "[%d]") then

                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_constants(): Invalid environment" ..
                                " constant value in remix",
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

    local biomes_path = unilib.remix_dir_table[remix_name] .. "/biomes.csv"
    local biome_count = 0
    local mini_check_table = {}

    if unilib.is_file(biomes_path) then

        for i, csv_table in ipairs(unilib.read_csv(biomes_path)) do

            local biome_name, description, orig_name, dust, top_str, fill_str, stone, water_top_str,
                    water, river, riverbed_str, cave_liquid, dungeon, dungeon_alt, dungeon_stair,
                    y_max, y_min, blend, heat, humidity = unpack(csv_table)

            if biome_name ~= nil and string.find(biome_name, "%a") then

                if mini_check_table[biome_name] ~= nil then

                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_biomes(): Duplicate biome table" ..
                                " in remix",
                        biomes_path,
                        i
                    )

                elseif biome_check_table[biome_name] ~= nil then

                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_biomes(): Biome table already" ..
                                " specified by another remix",
                        biomes_path,
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
                    table.insert(unilib.biome_setup_list, {
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

            end

        end

        -- Valid biome table
        unilib.remix_biome_count_table[remix_name] = biome_count

    end

    return biome_check_table

end

local function register_remix_decorations(remix_name, constants_table)

    -- Read the remix CSV containing decorations, and update global variables

    local deco_path = unilib.remix_dir_table[remix_name] .. "/decorations.csv"
    local deco_count = 0

    if unilib.is_file(deco_path) then

        for i, csv_table in ipairs(unilib.read_csv(deco_path)) do

            local deco_type, deco_name, y_max, y_min, biomes, place_on, spawn_by, num_spawn_by,
                fill_ratio, height_max, flags, sidelen = unpack(csv_table)

            if deco_type ~= nil then

                if deco_type ~= "simple" and
                        deco_type ~= "schematic" and
                        deco_type ~= "schematic_no_rotate" then

                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_decorations(): Invalid" ..
                                " decoration type in remix",
                        deco_path,
                        i
                    )

                elseif deco_name == nil or not string.find(deco_name, "%a") then

                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_decorations(): Invalid or" ..
                                " missing decoration name in remix",
                        deco_path,
                        i
                    )

                elseif deco_type ~= "simple" and string.find(deco_name, "%s") then

                    -- (Separating multiple node full_names is permitted)
                    unilib.show_warning(
                        "../lib/system/read_csv, register_remix_decorations(): Cannot specify" ..
                                " multiple schematic names on the same line",
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
                    table.insert(unilib.deco_setup_list, {
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

            end

        end

        -- Valid decoration table
        unilib.remix_deco_count_table[remix_name] = deco_count

    end

end

local function register_remix_ores(remix_name, constants_table)

    -- Read the remix CSVs containing ores, and update global variables

    local ore_type_list = {"scatter", "sheet", "puff", "blob", "vein", "stratum"}
    local ore_path_list = {}
    local ore_count = 0

    for _, ore_type in pairs(ore_type_list) do

        local ore_path = unilib.remix_dir_table[remix_name] .. "/ore_" .. ore_type .. ".csv"

        if unilib.is_file(ore_path) then

            for i, csv_table in ipairs(unilib.read_csv(ore_path)) do

                -- (All ore types)
                local ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes
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
                    np_octaves, np_persist, biomes = unpack(csv_table)

                elseif ore_type == "sheet" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, column_height_max, column_height_min,
                    column_midpoint_factor = unpack(csv_table)

                elseif ore_type == "puff" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, nppt_offset, nppt_scale, nppt_spread,
                    nppt_seed, nppt_octaves, nppt_persist, nppb_offset, nppb_scale, nppb_spread,
                    nppb_seed, nppb_octaves, nppb_persist = unpack(csv_table)

                elseif ore_type == "vein" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, random_factor = unpack(csv_table)

                elseif ore_type == "stratum" then

                    ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
                    y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed,
                    np_octaves, np_persist, biomes, npst_offset, npst_scale, npst_spread,
                    npst_seed, npst_octaves, npst_persist, stratum_thickness = unpack(csv_table)

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
                    table.insert(unilib.ore_setup_list, {
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

            end

        end

    end

    if ore_count > 0 then

        -- Valid ore table(s)
        if unilib.remix_ore_count_table[remix_name] == nil then

            unilib.remix_ore_count_table[remix_name] = ore_count

        else

            unilib.remix_ore_count_table[remix_name] =
                    unilib.remix_ore_count_table[remix_name] + ore_count

        end

    end

end

local function register_remix_other()

    -- Read the optional CSVs for each remix
    -- Compile an ordered list of biomes/decorations/ores that must be defined, ignoring any
    --      duplicates

    local biome_check_table = {}

    for _, remix_name in ipairs(unilib.remix_list) do

        local constants_table = register_remix_constants(remix_name)

        biome_check_table = register_remix_biomes(remix_name, constants_table, biome_check_table)

        register_remix_decorations(remix_name, constants_table)
        register_remix_ores(remix_name, constants_table)

    end

end

local function register_mtgame_aliases()

    -- Read the pre-generated CSV, mapping minetest_game nodes/craftitems/tools onto their
    --      unilib equivalents
    -- This is used to generate aliases, in case the unilib equivalents are not created

    local source_path = unilib.path_mod .. "/csv/convert/convert.csv"

    if not unilib.is_file(source_path) then

        unilib.show_warning(
            "../lib/system/read_csv, register_mtgame_aliases(): Missing CSV file", source_path
        )

        -- (Not a fatal error)
        return

    end

    for i, csv_table in ipairs(unilib.read_csv(source_path)) do

        local orig_name, unilib_name = unpack(csv_table)

        -- (Do nothing for ignorable lines)
        if orig_name ~= nil and string.find(orig_name, "%a") then

            unilib.mtgame_convert_table[orig_name] = unilib_name
            unilib.mtgame_deconvert_table[unilib_name] = orig_name

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Read CSVs
---------------------------------------------------------------------------------------------------

-- Register source mods. Checking for fatal_error_flag is included even here, in case more code os
--      inserted above later
if fatal_error_flag then
    unilib.show_warning("../lib/system/read_csv: Not checking source mods")
else
    register_source_mods()
end

-- Register imported mods
if fatal_error_flag then
    unilib.show_warning("../lib/system/read_csv: Not checking imported mods")
else
    register_imported_mods()
end

-- Register compatible mods
if fatal_error_flag then
    unilib.show_warning("../lib/system/read_csv: Not checking compatible mods")
else
    register_compatible_mods()
end

-- Register external mods
if fatal_error_flag then
    unilib.show_warning("../lib/system/read_csv: Not checking external mods")
else
    register_external_mods()
end

-- Register remixes
if fatal_error_flag then
    unilib.show_warning("../lib/system/read_csv: Not checking remixes")
else
    register_remixes()
end

-- Register remix packages
if fatal_error_flag then

    unilib.show_warning("../lib/system/read_csv: Not checking packages")

else

    for _, remix_name in ipairs(unilib.remix_list) do
        register_remix_packages(remix_name)
    end

end

-- Register remix biome/decoration/environental constant/ore tables
if fatal_error_flag then

    unilib.show_warning(
        "../lib/system/read_csv: Not checking remix biome/decoration/ore/environmental" ..
                " constant tables"
    )

else

    register_remix_other()

end

-- Register backup aliases for minetest_game items
if fatal_error_flag then
    unilib.show_warning("../lib/system/read_csv: Not checking minetest_game alias table")
else
    register_mtgame_aliases()
end

-- In case of a fatal error, reset the global variables set by this file, so that no packages are
--      imported at all
if fatal_error_flag then

    unilib.source_mod_table = {}
    unilib.imported_mod_table = {}
    unilib.remix_list = {}
    unilib.remix_pkg_count_table = {}
    unilib.pkg_setup_list = {}
    unilib.remix_biome_count_table = {}
    unilib.biome_setup_list = {}
    unilib.remix_deco_count_table = {}
    unilib.deco_setup_list = {}

end
