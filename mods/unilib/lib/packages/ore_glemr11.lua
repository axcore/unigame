---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_glemr11 = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

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

    -- Check arguments, if required
    for _, full_name in pairs(node_list) do

        if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

            if debug_warning_flag then
                unilib.utils.show_warning("ore_glemr11 package: Unrecognised node", full_name)
            end

            return false

        elseif unilib.utils.get_mod_name(full_name) ~= "unilib" then

            -- (Not a fatal error)
            if debug_warning_flag then
                unilib.utils.show_warning("ore_glemr11 package: Non-unilib node", full_name)
            end

        end

    end

    return true

end

local function register_ore(def_table)

    if not check_nodes({def_table.ore, def_table.wherein}) then
        return
    else
        unilib.register_ore(def_table)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_glemr11.init()

    return {
        description = "Ores for the GLEMr11 remix, combined into a single package",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = {"biome_glemr11", "dirt_custom_glemr11"},
    }

end

function unilib.pkg.ore_glemr11.post()

    -- Liquids in stone

    -- N.B. This ore is removed, as it creates enormous ugly holes on the surface
    --[[
    register_ore({
        ore_type                = "sheet",
        ore                     = "air",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 15,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 208,
        y_min                   = -508,
    })
    ]]--

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:liquid_water_river_source",
        wherein                 = "unilib:stone_limestone_white",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 66,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 208,
        y_min                   = -508,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:liquid_water_river_source",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 61,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 208,
        y_min                   = -508,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:liquid_oil_normal_source",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 41,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = -492,
        y_min                   = -1008,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:liquid_mud_boiling_source",
        wherein                 = "unilib:stone_desert",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 108,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 208,
        y_min                   = -508,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:sand_quicksand",
        wherein                 = "unilib:sand_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 64,
        clust_size              = 6,

        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        random_factor           = 1,
        y_max                   = 30,
        y_min                   = 4,
    })

    register_ore({
        ore_type                = "blob",
        ore                     = "unilib:dirt_mud_wet",
        wherein                 = "unilib:dirt_mud_swamp",

        clust_num_ores          = 8,
        clust_scarcity          = 64,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        random_factor           = 1,
        y_max                   = 30,
        y_min                   = 4,
    })

    -- Dirts and stones

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:dirt_clayey",
        wherein                 = "unilib:dirt_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 141,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:clay_red",
        wherein                 = "unilib:dirt_clayey",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 80,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:clay_ordinary",
        wherein                 = "unilib:dirt_clayey",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 14,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:dirt_sandy",
        wherein                 = "unilib:dirt_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 109,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:dirt_sandy",
        wherein                 = "unilib:sand_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 17,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:dirt_silt_fine",
        wherein                 = "unilib:dirt_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 78,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:sand_silt",
        wherein                 = "unilib:dirt_silt_fine",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 38,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:dirt_silt_coarse",
        wherein                 = "unilib:dirt_silt_fine",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 219,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_ordinary",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 122,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_desert",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 159,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_silver",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 18,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_desert",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 209,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_brownstone_dark",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 159,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_brown",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 187,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_desert",
        wherein                 = "unilib:stone_sandstone_brown",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            seed = 48,
            scale = 1,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_desert",
        wherein                 = "unilib:stone_sandstone_brown",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 42,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_brownstone_dark",
        wherein                 = "unilib:stone_sandstone_brown",

        clust_size              = 8,
        column_height_max       = 56,
        column_height_min       = 28,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.6,
            scale = 1,
            seed = 1,
            spread = {x = 128, y = 128, z = 128},
        },
        noise_threshold         = 0.8,
        y_max                   = 108,
        y_min                   = -8,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_chalk_white",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 30,
        column_height_min       = 20,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            seed = 2,
            spread = {x = 30, y = 30, z = 30},
        },
        noise_threshold         = 0.45,
        y_max                   = 58,
        y_min                   = -28,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 20,
        column_height_min       = 15,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            seed = 12,
            spread = {x = 45, y = 45, z = 45},
        },
        noise_threshold         = 0.5,
        y_max                   = 208,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff",
        wherein                 = "unilib:gravel_ordinary",

        clust_size              = 8,
        column_height_max       = 20,
        column_height_min       = 15,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            seed = 12,
            spread = {x = 45, y = 45, z = 45},
        },
        noise_threshold         = 0.5,
        y_max                   = 208,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff_rhyolitic",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 20,
        column_height_min       = 15,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            seed = 13,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.53,
        y_max                   = 208,
        y_min                   = -2008,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff_rhyolitic",
        wherein                 = "unilib:gravel_ordinary",

        clust_size              = 8,
        column_height_max       = 20,
        column_height_min       = 15,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.6,
            scale = 0.2,
            seed = 13,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.53,
        y_max                   = 208,
        y_min                   = -2008,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = "unilib:dirt_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = "unilib:gravel_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_gneiss_white",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_marble_grey",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_schist_grey",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_serpentine",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_shale_brown",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    register_ore({
        ore_type                = "sheet",
        ore                     = "unilib:stone_slate_grey",
        wherein                 = "unilib:stone_ordinary",

        clust_size              = 8,
        column_height_max       = 8,
        column_height_min       = 6,
        column_midpoint_factor  = 0.5,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 508,
        y_min                   = -208,
    })

    -- Metal and mineral ores

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -4096,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 5000,
        clust_size              = 2,
        y_max                   = -2048,
        y_min                   = -4095,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 5000,
        clust_size              = 2,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_desert_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 5000,
        clust_size              = 2,
        y_max                   = 200,
        y_min                   = -1,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_pegmatite_white_with_cassiterite",
        wherein                 = "unilib:stone_pegmatite_white",

        clust_num_ores          = 9,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_chalcopyrite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 12,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_galena",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_magnetite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 13,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_malachite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 11,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_sphalerite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 9,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -10,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_chromium",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 2,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -100,
        y_min                   = -200,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_chromium",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 2,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -200,
        y_min                   = -3100,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 30,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -128,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 64,
        y_min                   = -127,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 9,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 27,
        clust_scarcity          = 5000,
        clust_size              = 6,
        y_max                   = -16,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 64,
        y_min                   = -127,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -64,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -2048,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -1024,
        y_min                   = -2047,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = -255,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -512,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 5000,
        clust_size              = 2,
        y_max                   = -256,
        y_min                   = -511,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 5000,
        clust_size              = 2,
        y_max                   = -64,
        y_min                   = -255,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 29,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = -255,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 12,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 31000,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 27,
        clust_scarcity          = 5000,
        clust_size              = 6,
        y_max                   = -64,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -16,
        y_min                   = -63,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 16,
        y_min                   = -16,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -16,
        y_min                   = -128,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 31000,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 5000,
        clust_size              = 2,
        y_max                   = -512,
        y_min                   = -1023,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -1024,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_sandstone_desert",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = 20,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = 20,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_sandstone_ordinary",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = 20,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = 20,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = 20,
        y_min                   = -59,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 24,
        clust_scarcity          = 5000,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 24,
        clust_scarcity          = 5000,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 24,
        clust_scarcity          = 5000,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 31000,
        y_min                   = 1025,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = 64,
        y_min                   = -127,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_uranium",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -80,
        y_min                   = -300,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_zinc",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 5000,
        clust_size              = 7,
        y_max                   = 2,
        y_min                   = -32,
    })

    register_ore({
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_zinc",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 5000,
        clust_size              = 3,
        y_max                   = -32,
        y_min                   = unilib.constant.y_min,
    })


end
