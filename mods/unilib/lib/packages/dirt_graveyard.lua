---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grave
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_graveyard = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.grave.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_graveyard.init()

    return {
        description = "Graveyard dirt",
    }

end

function unilib.pkg.dirt_graveyard.exec()

    unilib.register_fertile_dirt({
        -- From grave:grave_dirt. Creates unilib:dirt_graveyard
        part_name = "dirt_graveyard",
        orig_name = "grave:grave_dirt",
        def_table = {
            description = S("Graveyard Dirt"),
            tiles = {"unilib_dirt_graveyard.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Graveyard Dirt"),
        compressed_group_table = {crumbly = 2},
    })

    unilib.register_dirt_with_turf({
        -- From grave:grave_dirt_with_grave_grass. Creates unilib:dirt_graveyard_with_turf_graveyard
        dirt_part_name = "dirt_graveyard",
        turf_part_name = "turf_graveyard",
        orig_name = "grave:grave_dirt_with_grave_grass",
        def_table = {
            description = S("Graveyard Dirt with Graveyard Turf"),
            tiles = {
                "unilib_turf_graveyard_top.png",
                "unilib_dirt_graveyard.png",
                {
                    name = "unilib_dirt_graveyard.png^unilib_turf_graveyard_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {
                crumbly = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_graveyard",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        turf_description = S("Graveyard Turf"),
    })

end
