---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_glemr11 = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

-- Table of schematics, loaded from ecosystems.csv, and their package dependences; see the comments
--      in .init()
local exception_table = {
    unilib_glem_tree_apple_mature_1 = "tree_apple_mature",
    unilib_glem_tree_banana_1 = "tree_apple_mature",
    unilib_glem_plant_bulrush_1 = "plant_reedmace",
}

-- In the code below, we need to be able to check both biomes that have been created, and those
--      that are waiting to be created
-- Table of biome names, compiled from core.registered_biomes() and
--      unilib.global.biome_csv_setup_list()
local biome_check_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function convert_to_list(arg)

    -- Modified version of unilib.utils.convert_to_list() (from utils.lua), taking into account that
    --      a string may be a list of whitespace-separated values

    if type(arg) == "table" then

        -- Already a list
        return arg

    elseif arg == nil or arg == "" then

        -- For nil/empty strings, return an empty list
        return {}

    else

        return unilib.utils.split_string_by_whitespace(arg, true)

    end

end

local function check_biomes(biome_list)

    -- Check arguments
    for _, biome_name in pairs(biome_list) do

        if core.registered_biomes[biome_name] == nil and
                unilib.global.biome_name_check_table[biome_name] == nil and
                biome_check_table[biome_name] == nil then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_glemr11 package: Unrecognised biome", biome_name)
            end

            return false

        end

    end

    return true

end

local function check_nodes(node_list)

    -- Register dirt on demand (see comments in the "dirt_custom_glemr11" package)
    if unilib.setting.dirt_on_demand_flag then

        for _, full_name in pairs(node_list) do

            if core.registered_nodes[full_name] == nil and
                    unilib.pkg.dirt_custom_glemr11.dirt_table[full_name] ~= nil then

                local data_table = unilib.pkg.dirt_custom_glemr11.dirt_table[full_name]
                if data_table.dirt_part_name == nil then

                    -- Short format, specifying only orig_name and the node definition
                    unilib.register_node(
                        full_name, data_table.orig_name, mode, data_table.def_table
                    )

                else

                    -- Long format, specifying everything required by calls to
                    --      unilib.register_dirt_with_turf()
                    unilib.register_dirt_with_turf(data_table)

                end

            end

        end

    end

    -- Check arguments
    for _, full_name in pairs(node_list) do

        if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_glemr11 package: Unrecognised node", full_name)
            end

            return false

        elseif unilib.utils.get_mod_name(full_name) ~= "unilib" then

            -- (Not a fatal error)
            if debug_warning_flag then
                unilib.utils.show_warning("deco_glemr11 package: Non-unilib node", full_name)
            end

        end

    end

    return true

end

local function check_schematics(schem_list)

    -- Check arguments
    for _, schem_name in pairs(schem_list) do

        if not unilib.utils.is_file(unilib.core.path_mod .. "/mts/" .. schem_name .. ".mts") then

            if debug_warning_flag then

                unilib.utils.show_warning(
                    "deco_glemr11 package: Missing schematic file", schem_name
                )

            end

            return false

        elseif exception_table[schem_name] ~= nil and
                unilib.global.pkg_executed_table[exception_table[schem_name]] == nil then

            if debug_warning_flag then

                unilib.utils.show_warning(
                    "deco_glemr11 package: Can\'t use decoration schematic because package not" ..
                            " executed",
                    schem_name,
                    exception_table[schem_name]
                )

            end

            return false

        end

    end

    return true

end

local function check_deco(data_table)

    -- Checks one of the values in unilib.global.deco_csv_setup_list (representing a decoration that
    --      hasn't been created yet) for validity

     -- (Don't act on decorations provides by other remixes)
    if data_table.remix_name ~= "glemr11" then
        return false
    end

    if data_table.deco_type == "simple" then

        -- If required, check that nodes actually exist, and register dirt on demand
        if not check_nodes(convert_to_list(data_table.deco_name)) then
            return false
        end

    elseif data_table.deco_type == "treelog" then

        -- Items in "treelog" constructions can the name of the schematic for the tree itself, or
        --      the full_name of the trunk node used to construct the log
        for _, item_name in ipairs(convert_to_list(data_table.deco_name)) do

            if not string.find(item_name, ":") then

                if not check_schematics({item_name}) then
                    return
                end

            else

                if not check_nodes({item_name}) then
                    return
                end

            end

        end

    else

        -- If required, check that the schematics actually exist and are suitable for use
        if not check_schematics(convert_to_list(data_table.deco_name)) then
            return false
        end

    end

    if data_table.place_on ~= nil then

        if not check_nodes(convert_to_list(data_table.place_on)) then
            return false
        end

    end

    if data_table.spawn_by ~= nil then

        if not check_nodes(convert_to_list(data_table.spawn_by)) then
            return false
        end

    end

    -- If required, check that biomes actually exist
    for _, biome_table in pairs(unilib.global.biome_csv_setup_list) do
        biome_check_table[biome_table.biome_name] = true
    end

    if data_table.biomes ~= nil then

        if not check_biomes(convert_to_list(data_table.biomes)) then
            return false
        end

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_glemr11.init()

    return {
        description = "Decorations from GLEMr11",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = "biome_glemr11",
        -- A few lines in decorations.csv will generate errors when the replace_mode for
        --      minetest_game mods is "defer", because the corresponding packages won't have been
        --      executed
        -- Rather than add an extra column to decorations.lua, specifying package dependencies
        --      (which will be empty in almost all cases), just use a simple exception table
        --      (specified above) to filter out any such problems
        -- The packages involved are those listed here
        optional = {"plant_reedmace", "tree_apple_mature"},
    }

end

function unilib.pkg.deco_glemr11.post()

    -- (Most) decorations for this remix are provided by the file decorations.csv. When loaded, the
    --      data is stored in unilib.global.deco_csv_setup_list until unilib is ready to create the
    --      decorations

    -- Compile a table of biome names for checking
    -- Some biomes have already been registered in core.registered_nodes(), others are waiting to be
    --      registered in unilib.global.biome_csv_setup_list()
    for name, _ in pairs(core.registered_biomes) do
        biome_check_table[name] = true
    end

    for _, data_table in pairs(unilib.global.biome_csv_setup_list) do
        biome_check_table[data_table.biome_name] = true
    end

    -- Check decorations loaded from CSV, filtering out any that are invalid
    local new_setup_list = {}
    for _, data_table in ipairs(unilib.global.deco_csv_setup_list) do

        if check_deco(data_table) then
            table.insert(new_setup_list, data_table)
        end

    end

    -- Update global variables
    unilib.global.deco_csv_setup_list = new_setup_list

    -- Add remaining GLEMr11 decorations (those not defined by the .csv)

    -- Coral reefs
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:coral_block_brown",
            "unilib:coral_block_orange",
            "unilib:coral_block_skeleton",
            "unilib:coral_rooted_blue",
            "unilib:coral_rooted_cyan",
            "unilib:coral_rooted_green",
            "unilib:coral_rooted_orange",
            "unilib:coral_rooted_pink",
            "unilib:coral_rooted_red",
        },

        biomes = {
            "glemr11_warm_temperate_ocean",
            "glemr11_temperate_humid_ocean",
            "glemr11_temperate_semihumid_ocean",
            "glemr11_temperate_temperate_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            seed = 7013,
            spread = {x = 50, y = 50, z = 50},
        },
        place_offset_y = -1,
        place_on = {"unilib:dirt_silt_coarse", "unilib:sand_ordinary"},
        sidelen = 4,
        y_max = -2,
        y_min = -12,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:coral_block_skeleton",
            "unilib:coral_brain",
            "unilib:coral_rooted_blue_glow",
            "unilib:coral_rooted_green_glow",
            "unilib:coral_rooted_orange_glow",
            "unilib:coral_rooted_pink_big",
            "unilib:coral_rooted_pink_glow",
            "unilib:plant_anemone_normal",
        },

        biomes = {
            "glemr11_warm_humid_ocean",
            "glemr11_warm_semihumid_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            spread = {x = 50, y = 50, z = 50},
            seed = 7013,
        },
        place_offset_y = -1,
        place_on = {"unilib:dirt_silt_coarse", "unilib:sand_ordinary"},
        sidelen = 4,
        y_max = -4,
        y_min = -14,
    })

    -- Kelp
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_kelp_yellow",

        biomes = {
            "glemr11_temperate_humid_ocean",
            "glemr11_temperate_semihumid_ocean",
            "glemr11_temperate_temperate_ocean",
            "glemr11_cool_humid_ocean",
            "glemr11_cool_semihumid_ocean",
            "glemr11_cool_temperate_ocean"
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        place_on = "unilib:sand_ordinary",
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_kelp_green",

        biomes = {
            "glemr11_temperate_humid_ocean",
            "glemr11_temperate_semihumid_ocean",
            "glemr11_temperate_temperate_ocean",
            "glemr11_cool_humid_ocean",
            "glemr11_cool_semihumid_ocean",
            "glemr11_cool_temperate_ocean"
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        place_on = "unilib:sand_ordinary",
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_kelp_green_thick",

        biomes = {
            "glemr11_temperate_humid_ocean",
            "glemr11_temperate_semihumid_ocean",
            "glemr11_temperate_temperate_ocean",
            "glemr11_cool_humid_ocean",
            "glemr11_cool_semihumid_ocean",
            "glemr11_cool_temperate_ocean"
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        place_on = "unilib:sand_ordinary",
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_seaweed_undersea",

        biomes = {
            "glemr11_temperate_humid_ocean",
            "glemr11_temperate_semihumid_ocean",
            "glemr11_temperate_temperate_ocean",
            "glemr11_cool_humid_ocean",
            "glemr11_cool_semihumid_ocean",
            "glemr11_cool_temperate_ocean"
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        place_on = "unilib:sand_ordinary",
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

    -- Sea Grass
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:grass_seagrass_1",
            "unilib:grass_seagrass_2",
            "unilib:grass_seagrass_3",
        },

        biomes = {
            "glemr11_hot_semiarid_ocean",
            "glemr11_warm_semiarid_ocean",
            "glemr11_temperate_semiarid_ocean",
            "glemr11_cool_semiarid_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        place_on = "unilib:sand_ordinary",
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

end
