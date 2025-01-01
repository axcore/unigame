---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_grove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_grove.init()

    return {
        description = "Ordinary dirt with grove turf",
        depends = "dirt_ordinary",
        optional = {"moss_green", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_grove.exec()

    unilib.register_dirt_with_turf({
        -- From ethereal:grove_dirt. Creates unilib:dirt_ordinary_with_turf_grove
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_grove",
        orig_name = "ethereal:grove_dirt",
        def_table = {
            description = S("Ordinary Dirt with Grove Turf"),
            tiles = {
                "unilib_turf_grove_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_grove_side_overlay.png",
                    tileable_vertical = false
                },
            },
            groups = {
                crumbly = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
                spreading_dirt_type = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = S("Grove Turf"),
    })
    if unilib.global.pkg_executed_table["moss_green"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_ordinary_with_turf_grove",
            "unilib:dirt_ordinary",
            "unilib:moss_green"
        )

    end

end
