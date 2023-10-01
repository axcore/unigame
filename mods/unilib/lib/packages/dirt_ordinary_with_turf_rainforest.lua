---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_rainforest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_rainforest.init()

    return {
        description = "Ordinary dirt with rainforest turf",
        notes = "In the original code, this item is provided as an alternative to dirt with" ..
                " rainforest litter, if the latter is not available. In any world designed" ..
                " to look like ethereal-ng, this item could be omitted",
        depends = "dirt_ordinary",
        optional = {"grass_jungle", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_rainforest.exec()

    unilib.register_dirt_with_turf({
        -- From ethereal:jungle_dirt. Creates unilib:dirt_ordinary_with_turf_rainforest
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_rainforest",
        orig_name = "ethereal:jungle_dirt",
        def_table = {
            description = S("Ordinary Dirt with Rainforest Turf"),
            tiles = {
                "unilib_turf_rainforest_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_rainforest_side_overlay.png",
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
        turf_description = S("Rainforest Turf"),
    })
    if unilib.pkg_executed_table["grass_jungle"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_turf_rainforest",
            "unilib:dirt_ordinary",
            "unilib:grass_jungle"
        )

    end

end
