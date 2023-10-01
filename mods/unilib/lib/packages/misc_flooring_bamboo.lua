---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_flooring_bamboo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_flooring_bamboo.init()

    return {
        description = "Bamboo flooring",
        depends = "tree_bamboo",
    }

end

function unilib.pkg.misc_flooring_bamboo.exec()

    unilib.register_node("unilib:misc_flooring_bamboo", "ethereal:bamboo_floor", mode, {
        -- From ethereal:bamboo_floor
        description = S("Bamboo Flooring"),
        tiles = {"unilib_misc_flooring_bamboo.png"},
        groups = {choppy = 3, flammable = 2, snappy = 3},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_flooring_bamboo.png",
        node_box = {
            type = "wallmounted",
            wall_top = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
            wall_side = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {type = "wallmounted"},
        walkable = true,
        wield_image = "unilib_misc_flooring_bamboo.png",
    })
    unilib.register_craft({
        -- From ethereal:bamboo_floor
        output = "unilib:misc_flooring_bamboo 2",
        recipe = {
            {"unilib:tree_bamboo_trunk", "unilib:tree_bamboo_trunk"},
            {"unilib:tree_bamboo_trunk", "unilib:tree_bamboo_trunk"},
        }
    })
    unilib.register_craft({
        -- From ethereal:bamboo_floor
        output = "unilib:tree_bamboo_block",
        recipe = {
            {"unilib:misc_flooring_bamboo"},
            {"unilib:misc_flooring_bamboo"},
        },
    })

end
