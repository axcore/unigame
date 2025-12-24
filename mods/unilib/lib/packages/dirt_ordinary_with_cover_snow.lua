---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_cover_snow = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_cover_snow.init()

    return {
        description = "Ordinary dirt with snow cover",
        optional = {"dirt_ordinary", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_cover_snow.exec()

    --[[
    unilib.register_node(
        -- From default:dirt_with_snow
        "unilib:dirt_ordinary_with_cover_snow",
        "default:dirt_with_snow",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Snow Cover"),
            tiles = {
                "unilib_snow_ordinary.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_snow_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {
                covered_dirt = 1, crumbly = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group, snowy = 1, soil = 1,
                spreading_dirt = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_snow_footstep", gain = 0.2},
            }),

            drop = "unilib:dirt_ordinary",
        }
    )
    ]]--
    unilib.register_dirt_with_turf({
        -- From default:dirt_with_snow. Creates unilib:dirt_ordinary_with_cover_snow
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "cover_snow",
        orig_name = "default:dirt_with_snow",
        def_table = {
            description = S("Ordinary Dirt with Snow Cover"),
            tiles = {
                "unilib_snow_ordinary.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_snow_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            -- N.B. covered_dirt = 1 not in original code
            -- N.B. spreading_dirt_type = 1 in the original code
            groups = {
                covered_dirt = 1, crumbly = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group, snowy = 1, soil = 1,
                spreading_dirt = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_snow_footstep", gain = 0.2},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        -- N.B. The turf cutter (etc) must create (ordinary) turf, not snow. See the notes in
        --      ../lib/shared/dirt/dirt_base.lua
        alt_turf_part_name = "turf",
        turf_description = S("Turf"),
        turf_seeder = "unilib:snow_ordinary",
    })

end
