---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_hairy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_hairy.init()

    return {
        description = "Hairy mushroom",
        depends = "tree_jungle",
    }

end

function unilib.pkg.mushroom_hairy.exec()

    unilib.register_node("unilib:mushroom_hairy", "nsspf:lentinus_strigosus", mode, {
        -- From nsspf:lentinus_strigosus
        description = unilib.annotate(S("Hairy Mushroom"), "Lentinus strigosus"),
        tiles = {"unilib_mushroom_hairy.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_hairy.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_hairy", 1),
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:mushroom_hairy_cooked", "nsspf:cooked_lentinus_strigosus", mode, {
        -- From nsspf:cooked_lentinus_strigosus
        description = S("Cooked Hairy Mushroom"),
        tiles = {"unilib_mushroom_hairy_cooked.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_hairy.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_hairy_cooked", 16),
    })
    unilib.register_craft({
        -- From nsspf:cooked_lentinus_strigosus
        type = "cooking",
        output = "unilib:mushroom_hairy_cooked",
        recipe = "unilib:mushroom_hairy",
        cooktime = 10,
    })

    -- (This mushroom grows on the top surface of a jungle tree trunk)
    unilib.pkg.shared_nsspf.register_special(
        "unilib:mushroom_hairy",
        "unilib:tree_jungle_trunk"
    )

end
