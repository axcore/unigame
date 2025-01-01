---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_glemr4 = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

-- The original code used random seeds; in this package we use a base value which is incremented,
--      whenever an ore distribution is generated
local base_seed = unilib.utils.get_mod_attribute("storage_random_seed_offset")

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_seed()

    -- Original to unilib
    -- Called when each ore is generated to produce a unique seed for it, that is consistent across
    --      sessions (because it is based on the "storage_random_seed_offset" attribute)

    base_seed = base_seed + 1
    return base_seed

end

local function register_ore(def_table)

    -- Because this package has no formal list of dependencies (but does depend on a lot of other
    --      packages), we can save a lot of trouble by checking for a node's existence, before
    --      using it in an ore

    if not unilib.utils.is_registered_node_or_mtgame_alias(def_table.ore) then

        if debug_warning_flag then
            unilib.utils.show_warning("ore_glemr4 package: Unrecognised node", def_table.ore)
        end

    elseif not unilib.utils.is_registered_node_or_mtgame_alias(def_table.wherein) then

        if debug_warning_flag then
            unilib.utils.show_warning("ore_glemr4 package: Unrecognised node", full_name)
        end

    else

        return unilib.register_ore(def_table)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_glemr4.init()

    return {
        description = "Ores for the GLEMr4 remix, combined into a single package",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
    }

end

function unilib.pkg.ore_glemr4.post()

    -- (Within ordinary stone, place other stone types as sheet ores)

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_ordinary",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 250,
        clust_scarcity          = 60,
        clust_size              = 10,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.1,
        random_factor           = 1.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1000,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_desert",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 250,
        clust_scarcity          = 60,
        clust_size              = 10,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.1,
        random_factor           = 1.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1000,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_silver",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 250,
        clust_scarcity          = 60,
        clust_size              = 10,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.1,
        random_factor           = 1.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1000,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_desert",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 250,
        clust_scarcity          = 60,
        clust_size              = 10,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.1,
        random_factor           = 1.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1000,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_brownstone_dark",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 250,
        clust_scarcity          = 60,
        clust_size              = 10,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.1,
        random_factor           = 1.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1000,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_brown",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 250,
        clust_scarcity          = 60,
        clust_size              = 10,
        noise_params            = {
            octaves = 5,
            offset = 0,
            persist = 0.60,
            scale = 1,
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.1,
        random_factor           = 1.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1000,
    })

    -- (Within brown sandstone, place other stone types as blob ores)

    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:stone_desert",
        wherein                 = "unilib:stone_sandstone_brown",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:stone_sandstone_desert",
        wherein                 = "unilib:stone_sandstone_brown",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:stone_brownstone_dark",
        wherein                 = "unilib:stone_sandstone_brown",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    -- (Place quicksand in ordinary sand)

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 30,
        y_min                    = 4,
    })

    -- (Place clayey/sandy/silty dirts in ordinary dirt)

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:dirt_sandy",
        wherein                 = "unilib:dirt_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    -- (Place clayey/sandy/silty dirts inside each other)

    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:clay_red",
        wherein                 = "unilib:dirt_clayey",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:dirt_silt_coarse",
        wherein                 = "unilib:dirt_silt_fine",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 71,
        y_min                   = -10,
    })

    -- (Place quartz ore in various stonetypes)

    register_ore({
        -- From GLEMr4
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
        -- From GLEMr4
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
        -- From GLEMr4
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
        -- From GLEMr4
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
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_quartz_white",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 10,
        clust_scarcity          = 5000,
        clust_size              = 5,
        y_max                   = -10,
        y_min                   = -59,
    })

    -- (Place metal/mineral ores in desert stone)

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 27,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 6,
        y_max                   = -16,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -16,
        y_min                   = -63,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 27,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 6,
        y_max                   = -64,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 14 * 14 * 14,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 2,
        y_max                   = -64,
        y_min                   = -255,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 4,
        clust_scarcity          = 17 * 17 * 17,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = -255,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 4,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -64,
        y_min                   = unilib.constant.y_min,
    })

    -- (Place coral sand in ordinary sand)

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:sand_undersea",
        wherein                 = "unilib:sand_ordinary",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    -- (Place technic/moreores metals in various stones)

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_brownstone_dark",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

    -- (Place iron ore in desert stone)

    register_ore({
        -- From GLEMr4
        ore_type                = "scatter",
        ore                     = "unilib:stone_desert_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 2,
        y_max                   = 200,
        y_min                   = -1,
    })

    -- (Place chalk and tuff inside ordinary stone and gravel)

    register_ore({
        -- From GLEMr4
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
            -- N.B. seed missing in original code
            seed = get_seed(),
            spread = {x = 30, y = 30, z = 30},
        },
        noise_threshold         = 0.45,
        y_max                   = 50,
        y_min                   = -20,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 45, y = 45, z = 45},
        },
        noise_threshold         = 0.5,
        y_max                   = 200,
        y_min                   = -200,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.53,
        y_max                   = 200,
        y_min                   = -2000,
    })

    -- (Place old red sandstone in ordinary stone, dirt or gravel)

    register_ore({
        -- From GLEMr4
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = {
            "unilib:dirt_ordinary",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
        },

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persist = 0.6,
            scale = 0.3,
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    -- (Place various other stone types in ordinary stone)

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    -- (Place stones from rocks mod)

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.333,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.333,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.38,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.38,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = 0.3,
    })

    register_ore({
        -- From GLEMr4
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
            seed = get_seed(),
            spread = {x = 256, y = 256, z = 256},
        },
        noise_threshold         = -0.1,
    })

end
