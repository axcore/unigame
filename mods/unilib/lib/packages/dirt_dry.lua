---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_dry.init()

    return {
        description = "Dry dirt",
        optional = {"grass_dry", "soil_arid"},
    }

end

function unilib.pkg.dirt_dry.exec()

    unilib.register_fertile_dirt({
        -- From default:dry_dirt. Creates unilib:dirt_dry
        part_name = "dirt_dry",
        orig_name = "default:dry_dirt",
        def_table = {
            description = S("Savanna Dirt"),
            tiles = {"unilib_dirt_dry.png"},
            -- N.B. dry_dirt = 1 not in original code
            groups = {crumbly = 3, dry_dirt = 1, soil = 1},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        dry_soil = "unilib:soil_arid",
        wet_soil = "unilib:soil_arid_wet",
    })

    -- Notes from default:
    -- Savanna bare dirt patches
    -- Must come before all savanna decorations that are placed on dry grass
    -- Noise is similar to long dry grass noise, but scale inverted, to appear where long dry grass
    --      is least dense and shortest
    unilib.register_decoration("default_dirt_dry", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:dirt_dry",

        flags = "force_placement",
        noise_params = {
            octaves = 4,
            offset = -1.5,
            persist = 1.0,
            scale = -1.5,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        place_offset_y = -1,
        sidelen = 4,
    })

    unilib.register_dirt_with_turf({
        -- From default:dry_dirt_with_dry_grass. Creates unilib:dirt_dry_with_turf_dry
        dirt_part_name = "dirt_dry",
        turf_part_name = "turf_dry",
        orig_name = "default:dry_dirt_with_dry_grass",
        def_table = {
            description = S("Savanna Dirt with Savanna Turf"),
            tiles = {
                "unilib_turf_dry_top.png",
                "unilib_dirt_dry.png",
                {
                    name = "unilib_dirt_dry.png^unilib_turf_dry_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            -- N.B. dry_dirt = 1 not in original code
            groups = {crumbly = 3, dry_dirt = 1, soil = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_dry",
            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        dry_soil = "unilib:soil_arid",
        wet_soil = "unilib:soil_arid_wet",
        turf_description = S("Savanna Turf"),
    })
    if unilib.pkg_executed_table["grass_dry"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_dry",
            "unilib:grass_dry_1"
        )

    end

end
