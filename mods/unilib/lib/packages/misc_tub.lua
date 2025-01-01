---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_tub = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_tub.init()

    return {
        description = "Tub",
        notes = "Used for crafting barrels, cannot contains liquids",
    }

end

function unilib.pkg.misc_tub.exec()

    unilib.register_node("unilib:misc_tub", "cottages:tub", mode, {
        -- From cottages:tub
        description = S("Tub"),
        tiles = {"unilib_container_barrel_normal.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5},
            },
        },
        drawtype = "mesh",
        is_ground_content = false,
        mesh = "unilib_misc_tub.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5},
            },
        },
    })

end
