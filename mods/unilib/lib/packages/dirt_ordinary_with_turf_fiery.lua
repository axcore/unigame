---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_fiery = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_fiery.init()

    return {
        description = "Ordinary dirt with fiery turf",
        depends = "dirt_ordinary",
        optional = {"plant_shrub_dry_fiery", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_fiery.exec()

    unilib.register_dirt_with_turf({
        -- From ethereal:fiery_dirt. Creates unilib:dirt_ordinary_with_turf_fiery
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_fiery",
        orig_name = "ethereal:fiery_dirt",
        def_table = {
            description = S("Ordinary Dirt with Fiery Turf"),
            tiles = {
                "unilib_turf_fiery_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_fiery_side_overlay.png",
                    tileable_vertical = false
                }
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = S("Fiery Turf"),
    })
    if unilib.pkg_executed_table["plant_shrub_dry_fiery"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_turf_fiery",
            "unilib:dirt_ordinary",
            "unilib:plant_shrub_dry_fiery"
        )

    end

end
