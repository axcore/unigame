---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_crystal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_crystal.init()

    return {
        description = "Ordinary dirty with crystal turf",
        depends = "dirt_ordinary",
        optional = {"plant_shrub_crystal", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_crystal.exec()

    unilib.register_dirt_with_turf({
        -- From ethereal:crystal_dirt. Creates unilib:dirt_ordinary_with_turf_crystal
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_crystal",
        orig_name = "ethereal:crystal_dirt",
        def_table = {
            description = S("Ordinary Dirt with Crystal Turf"),
            tiles = {
                "unilib_turf_crystal_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_crystal_side_overlay.png",
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
        turf_description = S("Crystal Turf"),
    })
    if unilib.pkg_executed_table["plant_shrub_crystal"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_turf_crystal",
            "unilib:dirt_ordinary",
            "unilib:plant_shrub_crystal"
        )

    end

end
