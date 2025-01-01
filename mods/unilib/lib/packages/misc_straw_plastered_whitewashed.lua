---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_straw_plastered_whitewashed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_straw_plastered_whitewashed.init()

    return {
        description = "Whitewashed plastered straw bale",
        depends = {"material_lime_slaked", "misc_straw_plastered"},
    }

end

function unilib.pkg.misc_straw_plastered_whitewashed.exec()

    unilib.register_node(
        -- From earthbuild:whitewashed_strawbale
        "unilib:misc_straw_plastered_whitewashed",
        "earthbuild:whitewashed_strawbale",
        mode,
        {
            description = S("Whitewashed Plastered Straw Bale"),
            tiles = {"unilib_dirt_whitewashed.png"},
            groups = {crumbly = 1, falling_node = 1, snappy = 1},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "normal",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From earthbuild:whitewashed_strawbale
        output = "unilib:misc_straw_plastered_whitewashed",
        recipe = {
            {"unilib:misc_straw_plastered_bale", "unilib:material_lime_slaked"},
        },
    })

end
