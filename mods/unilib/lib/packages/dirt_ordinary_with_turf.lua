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
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf.init()

    return {
        description = "Ordinary dirt with turf",
        optional = {"dirt_ordinary", "grass_jungle", "grass_ordinary", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf.exec()

    --[[
    unilib.register_node(
        -- From default:dirt_with_grass
        "unilib:dirt_ordinary_with_turf",
        "default:dirt_with_grass",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Turf"),
            tiles = {
                "unilib_turf_ordinary_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {
                covered_dirt = 1, crumbly = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
                spreading_dirt = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
        }
    )
    if unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_turf", {
            soil = {
                base = "unilib:dirt_ordinary_with_turf",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    ]]--
    unilib.register_dirt_with_turf({
        -- From default:dirt_with_grass. Creates unilib:dirt_ordinary_with_turf
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf",
        orig_name = "default:dirt_with_grass",
        def_table = {
            description = S("Ordinary Dirt with Turf"),
            tiles = {
                "unilib_turf_ordinary_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
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
        turf_description = S("Turf"),
        -- N.B. Not using group:ordinary_grass here, hoping to prevent compatibility issues
        turf_seeder = "group:normal_grass",
    })
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["grass_jungle"] ~= nil then

        unilib.register_craft({
            -- From moreblocks
            type = "shapeless",
            output = "unilib:dirt_ordinary_with_turf",
            recipe = {"unilib:grass_jungle", "unilib:dirt_ordinary"},
        })

    end
    if unilib.global.pkg_executed_table["grass_ordinary"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary",
            "unilib:grass_ordinary_1"
        )

    end

    unilib.register_node(
        -- From default:dirt_with_grass_footsteps
        "unilib:dirt_ordinary_with_turf_and_footsteps",
        "default:dirt_with_grass_footsteps",
        default_add_mode,
        {
            description = S("Footsteps in Ordinary Dirt with Turf"),
            tiles = {
                "unilib_turf_ordinary_top.png^unilib_footprint_ordinary_overlay.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            -- N.B. covered_dirt = 1 not in original code
            groups = {covered_dirt = 1, crumbly = 3, not_in_creative_inventory = 1, soil = 1},
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )

end
