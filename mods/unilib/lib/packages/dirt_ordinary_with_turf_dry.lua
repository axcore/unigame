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

unilib.pkg.dirt_ordinary_with_turf_dry = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_dry.init()

    return {
        description = "Ordinary dirt with dry (savanna) turf",
        optional = {"dirt_ordinary", "grass_dry", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_dry.exec()

    --[[
    unilib.register_node(
        -- From default:dirt_with_dry_grass
        "unilib:dirt_ordinary_with_turf_dry",
        "default:dirt_with_dry_grass",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Savanna Turf"),
            tiles = {
                "unilib_turf_dry_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_dry_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {
                covered_dirt = 1, crumbly = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
                spreading_dirt = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
        }
    )
    if unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_turf_dry", {
            soil = {
                base = "unilib:dirt_ordinary_with_turf_dry",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    ]]--
    unilib.register_dirt_with_turf({
        -- From default:dirt_with_dry_grass. Creates unilib:dirt_ordinary_with_turf_dry
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_dry",
        orig_name = "default:dirt_with_dry_grass",
        def_table = {
            description = S("Ordinary Dirt with Savanna Turf"),
            tiles = {
                "unilib_turf_dry_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_dry_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            -- N.B. covered_dirt = 1 not in original code
            -- N.B. spreading_dirt_type = 1 in the original code
            groups = {
                covered_dirt = 1, crumbly = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
                spreading_dirt = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = S("Savanna Turf"),
        turf_seeder = "group:dry_grass",
    })
    if unilib.global.pkg_executed_table["grass_dry"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary",
            "unilib:grass_dry_1"
        )

    end

end
