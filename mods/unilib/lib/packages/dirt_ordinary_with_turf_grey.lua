---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_grey.init()

    return {
        description = "Ordinary dirt with grey turf",
        depends = "dirt_ordinary",
        optional = {"plant_shrub_snowy", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_grey.exec()

    unilib.register_dirt_with_turf({
        -- From ethereal:gray_dirt. Creates unilib:dirt_ordinary_with_turf_grey
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_grey",
        orig_name = "ethereal:gray_dirt",
        def_table = {
            description = S("Ordinary Dirt with Grey Turf"),
            tiles = {
                "unilib_turf_grey_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_grey_side_overlay.png",
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
        turf_description = S("Grey Turf"),
    })
    if unilib.global.pkg_executed_table["plant_shrub_snowy"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_ordinary_with_turf_grey",
            "unilib:dirt_ordinary",
            "unilib:plant_shrub_snowy"
        )

    end

end
