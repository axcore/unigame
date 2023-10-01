---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_glemr6 = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

local mapgen_seed = tonumber(minetest.get_mapgen_setting("seed"))

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

-- N.B. Some of these functions are not actually called, but perhaps they can be re-used when
--      importing later versions of GLEM

local function check_biomes(biome_list)

    -- Check arguments
    for _, biome_name in pairs(biome_list) do

        if minetest.registered_biomes[biome_name] == nil then

            if debug_warning_flag then
                unilib.show_warning("ore_glemr6 package: Unrecognised biome", biome_name)
            end

            return false

        end

    end

    return true

end

local function check_nodes(node_list)

    -- Register dirt on demand (see comments in the "dirt_custom_glemr6" package)
    if unilib.glem_dirt_on_demand_flag then

        for _, full_name in pairs(node_list) do

            if minetest.registered_nodes[full_name] == nil and
                    unilib.pkg.dirt_custom_glemr6.dirt_table[full_name] ~= nil then

                local data_table = unilib.pkg.dirt_custom_glemr6.dirt_table[full_name]
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

        if not unilib.is_registered_node_or_mtgame_alias(full_name) then

            if debug_warning_flag then
                unilib.show_warning("ore_glemr6 package: Unrecognised node", full_name)
            end

            return false

        elseif unilib.get_mod_name(full_name) ~= "unilib" then

            -- (Not a fatal error)
            if debug_warning_flag then
                unilib.show_warning("ore_glemr6 package: Non-unilib node", full_name)
            end

        end

    end

    return true

end

local function add_ore_scatter(a, b, c, d, e, f, g)

    if not check_nodes(unilib.convert_to_list(a)) or not check_nodes(unilib.convert_to_list(b)) then
        return
    end

    unilib.register_ore({
        ore_type                = "scatter",
        ore                     = a,
        wherein                 = b,

        clust_scarcity          = c,
        clust_num_ores          = d,
        clust_size              = e,
        y_min                   = f,
        y_max                   = g,
    })

end

local function add_ore_sheet(full_name, wherein_list, density, biome_list)

    if not check_biomes(biome_list) or
            not check_nodes( {full_name} ) or
            not check_nodes(wherein_list) then
        return
    end

    unilib.register_ore({
        ore_type                = "sheet",
        ore                     = full_name,
        wherein                 = wherein_list,

         biomes                  = biome_list or nil,
        clust_size              = 40,
        column_height_max       = 16,
        column_height_min       = 1,
        column_midpoint_factor
                                = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            -- N.B. The original code produces a fractional seed; replace it with an integer seed
            --      throughout this package
--            seed = mapgen_seed + math.random(),
            seed = mapgen_seed + unilib.get_random_seed(),
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = density,
        y_max                   = unilib.y_max,
        y_min                   = -1000,
    })

end

local function add_ore_sheet_arid(full_name, wherein_list, density, biome_list)

    if not check_biomes(biome_list) or
            not check_nodes( {full_name} ) or
            not check_nodes(wherein_list) then
        return
    end

    unilib.register_ore({
        ore_type                = "sheet",
        ore                     = full_name,
        wherein                 = wherein_list,

         biomes                  = biome_list or nil,
        clust_size              = 40,
        column_height_max       = 16,
        column_height_min       = 1,
        column_midpoint_factor
                                = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
--            seed = mapgen_seed + math.random(),
            seed = mapgen_seed + unilib.get_random_seed(),
            spread = {x = 512, y = 512, z = 512},
        },
        noise_threshold         = density,
        y_max                   = unilib.y_max,
        y_min                   = -1000,
    })

end

local function add_ore_sheet_semiarid(full_name, wherein_list, density, biome_list)

    if not check_biomes(biome_list) or
            not check_nodes( {full_name} ) or
            not check_nodes(wherein_list) then
        return
    end

    unilib.register_ore({
        ore_type                = "sheet",
        ore                     = full_name,
        wherein                 = wherein_list,

         biomes                  = biome_list or nil,
        clust_size              = 40,
        column_height_max       = 16,
        column_height_min       = 1,
        column_midpoint_factor
                                = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
--            seed = mapgen_seed + math.random(),
            seed = mapgen_seed + unilib.get_random_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = density,
        y_max                   = unilib.y_max,
        y_min                   = -1000,
    })

end

local function add_ore_sheet_temperate(full_name, wherein_list, density, biome_list)

    if not check_biomes(biome_list) or
            not check_nodes( {full_name} ) or
            not check_nodes(wherein_list) then
        return
    end

    unilib.register_ore({
        ore_type                = "sheet",
        ore                     = full_name,
        wherein                 = wherein_list,

         biomes                  = biome_list or nil,
        clust_size              = 40,
        column_height_max       = 16,
        column_height_min       = 1,
        column_midpoint_factor
                                = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
--            seed = mapgen_seed + math.random(),
            seed = mapgen_seed + unilib.get_random_seed(),
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = density,
        y_max                   = unilib.y_max,
        y_min                   = -1000,
    })

end

local function add_ore_sheet_semihumid(full_name, wherein_list, density, biome_list)

    if not check_biomes(biome_list) or
            not check_nodes( {full_name} ) or
            not check_nodes(wherein_list) then
        return
    end

    unilib.register_ore({
        ore_type                = "sheet",
        ore                     = full_name,
        wherein                 = wherein_list,

         biomes                  = biome_list or nil,
        clust_size              = 40,
        column_height_max       = 16,
        column_height_min       = 1,
        column_midpoint_factor
                                = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
--            seed = mapgen_seed + math.random(),
            seed = mapgen_seed + unilib.get_random_seed(),
            spread = {x = 128, y = 128, z = 128},
        },
        y_max                   = unilib.y_max,
        y_min                   = -1000,
        noise_threshold         = density,
    })

end

local function add_ore_sheet_humid(full_name, wherein_list, density, biome_list)

    if not check_biomes(biome_list) or
            not check_nodes( {full_name} ) or
            not check_nodes(wherein_list) then
        return
    end

    unilib.register_ore({
        ore_type                = "sheet",
        ore                     = full_name,
        wherein                 = wherein_list,

         biomes                  = biome_list or nil,
        clust_size              = 40,
        column_height_max       = 16,
        column_height_min       = 1,
        column_midpoint_factor
                                = 0.5,
        noise_params = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
--            seed = mapgen_seed + math.random(),
            seed = mapgen_seed + unilib.get_random_seed(),
            spread = {x = 64, y = 64, z = 64},
        },
        noise_threshold         = density,
        y_max                   = unilib.y_max,
        y_min                   = -1000,
    })

end

local function add_dirt_as_ore()

    add_ore_sheet("unilib:dirt_ordinary_with_litter_rainforest", {"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.4, {"glemr6_hot_humid_coastal"})
    add_ore_sheet_humid("unilib:dirt_ordinary_with_litter_rainforest", {"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.6, {"glemr6_hot_humid_lowland"})
    add_ore_sheet_humid("unilib:dirt_ordinary_with_litter_rainforest", {"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.8, {"glemr6_hot_humid_shelf"})
    add_ore_sheet_humid("unilib:dirt_ordinary_with_litter_rainforest", {"unilib:dirt_ordinary_with_turf_hot_humid_highland"},1.0, {"glemr6_hot_humid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_hot_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.2, {"glemr6_hot_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.2, {"glemr6_hot_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_hot_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.4, {"glemr6_hot_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.4, {"glemr6_hot_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_hot_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.6, {"glemr6_hot_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.6, {"glemr6_hot_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_hot_semihumid_highland", {"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.8, {"glemr6_hot_semihumid_highland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_hot_semihumid_highland", {"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.8, {"glemr6_hot_semihumid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_hot_temperate_coastal", {"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.2, {"glemr6_hot_temperate_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_hot_temperate_coastal", {"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.2, {"glemr6_hot_temperate_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_hot_temperate_lowland", {"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.4, {"glemr6_hot_temperate_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_hot_temperate_lowland", {"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.4, {"glemr6_hot_temperate_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_hot_temperate_shelf", {"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.6, {"glemr6_hot_temperate_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_hot_temperate_shelf", {"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.6, {"glemr6_hot_temperate_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_hot_temperate_highland", {"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.8, {"glemr6_hot_temperate_highland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_hot_temperate_highland", {"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.8, {"glemr6_hot_temperate_highland"})

    add_ore_sheet_arid("unilib:dirt_brown_with_turf_hot_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.2, {"glemr6_hot_semiarid_coastal"})
    add_ore_sheet_arid("unilib:dirt_sandy_with_turf_hot_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.2, {"glemr6_hot_semiarid_coastal"})
      add_ore_sheet_arid("unilib:dirt_brown_with_turf_hot_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.4, {"glemr6_hot_semiarid_lowland"})
    add_ore_sheet_arid("unilib:dirt_sandy_with_turf_hot_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.4, {"glemr6_hot_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_hot_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.6, {"glemr6_hot_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_hot_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.6, {"glemr6_hot_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_hot_semiarid_highland", {"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.8, {"glemr6_hot_semiarid_highland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_hot_semiarid_highland", {"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.8, {"glemr6_hot_semiarid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_warm_humid_coastal", {"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.8, {"glemr6_warm_humid_coastal"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_warm_humid_coastal", {"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.8, {"glemr6_warm_humid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_warm_humid_lowland", {"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.8, {"glemr6_warm_humid_lowland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_warm_humid_lowland", {"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.8, {"glemr6_warm_humid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_warm_humid_shelf", {"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.8, {"glemr6_warm_humid_shelf"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_warm_humid_shelf", {"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.8, {"glemr6_warm_humid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_warm_humid_highland", {"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.8, {"glemr6_warm_humid_highland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_warm_humid_highland", {"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.8, {"glemr6_warm_humid_highland"})
    add_ore_sheet("unilib:dirt_ordinary_with_litter_rainforest", {"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.8, {"glemr6_warm_humid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_warm_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.6, {"glemr6_warm_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.6, {"glemr6_warm_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_warm_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.6, {"glemr6_warm_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.6, {"glemr6_warm_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_warm_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.6, {"glemr6_warm_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.6, {"glemr6_warm_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_warm_semihumid_highland", {"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.6, {"glemr6_warm_semihumid_highland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_semihumid_highland", {"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.6, {"glemr6_warm_semihumid_highland"})

    add_ore_sheet("unilib:dirt_brown_with_turf_warm_temperate_coastal", {"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.4, {"glemr6_warm_temperate_coastal"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_temperate_coastal", {"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.4, {"glemr6_warm_temperate_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_temperate_lowland", {"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.4, {"glemr6_warm_temperate_lowland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_temperate_lowland", {"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.4, {"glemr6_warm_temperate_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_temperate_shelf", {"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.4, {"glemr6_warm_temperate_shelf"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_temperate_shelf", {"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.4, {"glemr6_warm_temperate_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_warm_temperate_highland", {"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.4, {"glemr6_warm_temperate_highland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_temperate_highland", {"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.4, {"glemr6_warm_temperate_highland"})

    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.2, {"glemr6_warm_semiarid_coastal"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_warm_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.2, {"glemr6_warm_semiarid_coastal"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.4, {"glemr6_warm_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_warm_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.4, {"glemr6_warm_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.6, {"glemr6_warm_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_warm_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.6, {"glemr6_warm_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_warm_semiarid_highland", {"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.8, {"glemr6_warm_semiarid_highland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_warm_semiarid_highland", {"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.8, {"glemr6_warm_semiarid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_temperate_humid_coastal", {"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.8, {"glemr6_temperate_humid_coastal"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_temperate_humid_coastal", {"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.8, {"glemr6_temperate_humid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_temperate_humid_lowland", {"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.8, {"glemr6_temperate_humid_lowland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_temperate_humid_lowland", {"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.8, {"glemr6_temperate_humid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_temperate_humid_shelf", {"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.8, {"glemr6_temperate_humid_shelf"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_temperate_humid_shelf", {"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.8, {"glemr6_temperate_humid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_temperate_humid_highland", {"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.8, {"glemr6_temperate_humid_highland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_temperate_humid_highland", {"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.8, {"glemr6_temperate_humid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_temperate_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.6, {"glemr6_temperate_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.6, {"glemr6_temperate_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_temperate_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.6, {"glemr6_temperate_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.6, {"glemr6_temperate_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_temperate_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.6, {"glemr6_temperate_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.6, {"glemr6_temperate_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_temperate_semihumid_highland", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.6, {"glemr6_temperate_semihumid_highland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_semihumid_highland", {"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.6, {"glemr6_temperate_semihumid_highland"})

    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_temperate_coastal", {"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.4, {"glemr6_temperate_temperate_coastal"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_temperate_coastal", {"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.4, {"glemr6_temperate_temperate_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_temperate_lowland", {"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.4, {"glemr6_temperate_temperate_lowland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_temperate_lowland", {"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.4, {"glemr6_temperate_temperate_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_temperate_shelf", {"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_temperate_shelf", {"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_temperate_temperate_highland", {"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.4, {"glemr6_temperate_temperate_highland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_temperate_highland", {"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.4, {"glemr6_temperate_temperate_highland"})

    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.2, {"glemr6_temperate_semiarid_coastal"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_temperate_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.2, {"glemr6_temperate_semiarid_coastal"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.4, {"glemr6_temperate_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_temperate_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.4, {"glemr6_temperate_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.6, {"glemr6_temperate_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_temperate_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.6, {"glemr6_temperate_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_temperate_semiarid_highland", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.8, {"glemr6_temperate_semiarid_highland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_temperate_semiarid_highland", {"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.8, {"glemr6_temperate_semiarid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_cool_humid_coastal", {"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.2, {"glemr6_cool_humid_coastal"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_cool_humid_coastal", {"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.2, {"glemr6_cool_humid_coastal"})
    add_ore_sheet("unilib:dirt_ordinary_with_litter_coniferous", {"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.4, {"glemr6_cool_humid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_cool_humid_lowland", {"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.4, {"glemr6_cool_humid_lowland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_cool_humid_lowland", {"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.4, {"glemr6_cool_humid_lowland"})
    add_ore_sheet("unilib:dirt_ordinary_with_litter_coniferous", {"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.6, {"glemr6_cool_humid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_cool_humid_shelf", {"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.6, {"glemr6_cool_humid_shelf"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_cool_humid_shelf", {"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.6, {"glemr6_cool_humid_shelf"})
    add_ore_sheet("unilib:dirt_ordinary_with_litter_coniferous", {"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.8, {"glemr6_cool_humid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_cool_humid_highland", {"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.8, {"glemr6_cool_humid_highland"})
    add_ore_sheet("unilib:dirt_silt_fine_with_turf_cool_humid_highland", {"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.8, {"glemr6_cool_humid_highland"})
    add_ore_sheet("unilib:dirt_ordinary_with_litter_coniferous", {"unilib:dirt_ordinary_with_turf_cool_humid_highland"},1.0, {"glemr6_cool_humid_highland"})

    add_ore_sheet("unilib:dirt_black_with_turf_cool_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.2, {"glemr6_cool_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_semihumid_coastal", {"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.2, {"glemr6_cool_semihumid_coastal"})
    add_ore_sheet("unilib:dirt_black_with_turf_cool_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.4, {"glemr6_cool_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_semihumid_lowland", {"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.4, {"glemr6_cool_semihumid_lowland"})
    add_ore_sheet("unilib:dirt_black_with_turf_cool_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.6, {"glemr6_cool_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_semihumid_shelf", {"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.6, {"glemr6_cool_semihumid_shelf"})
    add_ore_sheet("unilib:dirt_black_with_turf_cool_semihumid_highland", {"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.8, {"glemr6_cool_semihumid_highland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_semihumid_highland", {"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.8, {"glemr6_cool_semihumid_highland"})

    add_ore_sheet("unilib:dirt_brown_with_turf_cool_temperate_coastal", {"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.2, {"glemr6_cool_temperate_coastal"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_temperate_coastal", {"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.2, {"glemr6_cool_temperate_coastal"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_temperate_lowland", {"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.4, {"glemr6_cool_temperate_lowland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_temperate_lowland", {"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.4, {"glemr6_cool_temperate_lowland"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_temperate_shelf", {"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.6, {"glemr6_cool_temperate_shelf"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_temperate_shelf", {"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.6, {"glemr6_cool_temperate_shelf"})
    add_ore_sheet("unilib:dirt_brown_with_turf_cool_temperate_highland", {"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.8, {"glemr6_cool_temperate_highland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_temperate_highland", {"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.8, {"glemr6_cool_temperate_highland"})

    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.2, {"glemr6_cool_semiarid_coastal"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_cool_semiarid_coastal", {"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.2, {"glemr6_cool_semiarid_coastal"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.4, {"glemr6_cool_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_cool_semiarid_lowland", {"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.4, {"glemr6_cool_semiarid_lowland"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.6, {"glemr6_cool_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_cool_semiarid_shelf", {"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.6, {"glemr6_cool_semiarid_shelf"})
    add_ore_sheet("unilib:dirt_clayey_with_turf_cool_semiarid_highland", {"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.8, {"glemr6_cool_semiarid_highland"})
    add_ore_sheet("unilib:dirt_sandy_with_turf_cool_semiarid_highland", {"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.8, {"glemr6_cool_semiarid_highland"})

end

local function add_metal_mineral_as_ore()

    -- Coal
    add_ore_scatter("unilib:stone_ordinary_with_coal", "unilib:stone_desert", 24 * 24 * 24, 27, 6, unilib.y_min, -16)

    -- Copper
    add_ore_scatter("unilib:stone_ordinary_with_copper", "unilib:stone_desert", 9 * 9 * 9, 5, 3, unilib.y_min, -64)

    -- Diamond
    add_ore_scatter("unilib:stone_ordinary_with_diamond", "unilib:stone_desert", 17 * 17 * 17, 4, 3, -255, -128)
    add_ore_scatter("unilib:stone_ordinary_with_diamond", "unilib:stone_desert", 15 * 15 * 15, 4, 3, unilib.y_min, -256)

    -- Gold
    add_ore_scatter("unilib:stone_ordinary_with_gold", "unilib:stone_desert", 15 * 15 * 15, 3, 2, -255, -64)
    add_ore_scatter("unilib:stone_ordinary_with_gold", "unilib:stone_desert", 13 * 13 * 13, 5, 3, unilib.y_min, -256)

    -- Iron
    add_ore_scatter("unilib:stone_ordinary_with_iron", "unilib:stone_desert", 9 * 9 * 9, 5, 3, -63, -16)
    add_ore_scatter("unilib:stone_ordinary_with_iron", "unilib:stone_desert", 24 * 24 * 24, 27, 6, unilib.y_min, -64)

    -- Lead
    add_ore_scatter("unilib:stone_ordinary_with_lead", "unilib:stone_ordinary", 10 * 10 * 10, 24, 4, -100, -10)
    add_ore_scatter("unilib:stone_ordinary_with_lead", "unilib:stone_desert", 10 * 10 * 10, 24, 4, -100, -10)
    add_ore_scatter("unilib:stone_ordinary_with_lead", "unilib:stone_brownstone_dark", 10 * 10 * 10, 24, 4, -100, -10)

    -- Mese
    add_ore_scatter("unilib:stone_ordinary_with_mese", "unilib:stone_desert", 14 * 14 * 14, 5, 3, unilib.y_min, -256)

    -- Silver
    add_ore_scatter("unilib:stone_ordinary_with_silver", "unilib:stone_ordinary", 10 * 10 * 10, 24, 4, -100, -10)
    add_ore_scatter("unilib:stone_ordinary_with_silver", "unilib:stone_desert", 10 * 10 * 10, 24, 4, -100, -10)
    add_ore_scatter("unilib:stone_ordinary_with_silver", "unilib:stone_brownstone_dark", 10 * 10 * 10, 24, 4, -100, -10)

end

local function register_ore(def_table)

    -- Called by the code in .post(), when none of the functions above are used
    -- Because this package has no formal list of dependencies (but does depend on a lot of other
    --      packages), we can save a lot of trouble by checking for a node's existence, before
    --      using it in an ore

    if not unilib.is_registered_node_or_mtgame_alias(def_table.ore) then

        if debug_warning_flag then
            unilib.show_warning("ore_glemr6 package: Unrecognised node", def_table.ore)
        end

    elseif not unilib.is_registered_node_or_mtgame_alias(def_table.wherein) then

        if debug_warning_flag then
            unilib.show_warning("ore_glemr6 package: Unrecognised node", full_name)
        end

    else

        return unilib.register_ore(def_table)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_glemr6.init()

    return {
        description = "Ores for the GLEMr6 remix, combined into a single package",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = {"biome_glemr6", "dirt_custom_glemr6"},
    }

end

function unilib.pkg.ore_glemr6.post()

    -- Diversify the grass in each biome, by adding similar grass variants as ore
    add_dirt_as_ore()

    -- Add mineral/metal ores as scatters
    add_metal_mineral_as_ore()

    -- Place water in ordinary stone
    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:liquid_water_ordinary_source",
        wherein                 = "unilib:stone_limestone_white",

        clust_num_ores          = 16 * 16,
        clust_scarcity          = 16 * 4 * 16,
        clust_size              = 16,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 163281090,
            spread = {x = 256, y = 256, z = 256},
        },
        y_max                = -11,
        y_min                = -50,
    })

    -- Quicksand and mud
    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:sand_quicksand",
        wherein                 = "unilib:sand_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 30,
        y_min                   = 4,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:dirt_mud_wet",
        wherein                 = "unilib:dirt_mud_swamp",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 30,
        y_min                   = 4,
    })

    -- Place clay, sand and silt in dirt
    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:dirt_clayey",
        wherein                 = "unilib:dirt_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:clay_red",
        wherein                 = {"unilib:dirt_ordinary", "unilib:dirt_clayey"},

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:clay_ordinary",
        wherein                 = {"unilib:dirt_ordinary", "unilib:dirt_clayey"},

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:dirt_sandy",
        wherein                 = {"unilib:dirt_ordinary", "unilib:sand_ordinary"},

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -613,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:dirt_silt_fine",
        wherein                 = "unilib:dirt_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:sand_silt",
        wherein                 = {"unilib:dirt_ordinary", "unilib:dirt_silt_fine"},

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -613,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:dirt_silt_coarse",
        wherein                 = {"unilib:dirt_ordinary", "unilib:dirt_silt_fine"},

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -613,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    -- Quartz
    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_sandstone_desert",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_sandstone_ordinary",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -10,
        y_min                   = -59,
    })

    -- Place desert stone with iron
    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_desert_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 2,
        y_max                   = 200,
        y_min                   = -1,
    })

    -- Place chalk in mountains
    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_chalk_white",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 30,
        column_height_min       = 20,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            -- N.B. No seed in original code
            seed = mapgen_seed + 11,
            spread = {x = 30, y = 30, z = 30},
        },
        noise_threshold         = 0.45,
        y_max                   = 50,
        y_min                   = -20,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff",
        wherein                 = {"unilib:stone_ordinary",  "unilib:gravel_ordinary"},

        column_height_max       = 20,
        column_height_min       = 15,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.19,
            seed = mapgen_seed + 12,
            spread = {x = 45, y = 45, z = 45},
        },
        noise_threshold         = 0.5,
        y_max                   = 200,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff_rhyolitic",
        wherein                 = {"unilib:stone_ordinary", "unilib:gravel_ordinary"},

        column_height_max       = 20,
        column_height_min       = 15,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            seed = mapgen_seed + 13,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.53,
        y_max                   = 200,
        y_min                   = -2000,
    })

    -- Place old red sandstone
    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = {"unilib:stone_ordinary", "unilib:dirt_ordinary", "unilib:gravel_ordinary"},

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    -- Place gneiss, marble, schist, serpentine, shale and slate
    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_gneiss_white",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_marble_grey",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_schist_grey",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_serpentine",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_shale_brown",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_slate_grey",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = mapgen_seed + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    -- Place skarn mixes
    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_chalcopyrite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 12,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 163281090,
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.333,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_malachite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 11,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            spread = {x = 256, y = 256, z = 256},
            seed = 163281090,
        },
        noise_threshold         = 0.333,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_sphalerite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 9,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 163281090,
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.38,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_galena",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 10,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 163281090,
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.38,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_magnetite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 13,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 163281090,
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.3,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_pegmatite_white_with_cassiterite",
        wherein                 = "unilib:stone_pegmatite_white",

        clust_num_ores          = 9,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 163281090,
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = -0.1,
    })

end
