---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_mushroom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_mushroom.init()

    return {
        description = "Ordinary dirt with mushroom turf",
        depends = "dirt_ordinary",
        optional = {"mushroom_red", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_turf_mushroom.exec()

    unilib.register_dirt_with_turf({
        -- From ethereal:mushroom_dirt. Creates unilib:dirt_ordinary_with_turf_mushroom
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_mushroom",
        orig_name = "ethereal:mushroom_dirt",
        def_table = {
            description = S("Ordinary Dirt with Mushroom Turf"),
            tiles = {
                "unilib_turf_mushroom_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_mushroom_side_overlay.png",
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
        turf_description = S("Mushroom Turf"),
    })
    if unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_turf_mushroom",
            "unilib:dirt_ordinary",
            "unilib:mushroom_red"
        )

    end

end
