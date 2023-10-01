---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_azurea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_azurea.init()

    return {
        description = "Azurea mushroom",
        depends = {"shared_nsspf", "tree_jungle"},
    }

end

function unilib.pkg.mushroom_azurea.exec()

    unilib.register_node("unilib:mushroom_azurea", "nsspf:clitocybula_azurea", mode, {
        -- From nsspf:clitocybula_azurea
        description = unilib.annotate(S("Azurea Mushroom"), "Clitocybula_azurea"),
        tiles = {"unilib_mushroom_azurea.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_azurea.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_azurea", -6),
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:mushroom_azurea_cooked", "nsspf:cooked_clitocybula_azurea", mode, {
        -- From nsspf:cooked_clitocybula_azurea
        description = S("Cooked Azurea Mushroom"),
        tiles = {"unilib_mushroom_azurea_cooked.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_azurea.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_azurea_cooked", 10),
    })
    unilib.register_craft({
        -- From nsspf:cooked_clitocybula_azurea
        type = "cooking",
        output = "unilib:mushroom_azurea_cooked",
        recipe = "unilib:mushroom_azurea",
        cooktime = 10,
    })

    unilib.pkg.shared_nsspf.register_mushroom({
        -- Code original to unilib, replacing an ABM in the original code
        wall_name = "unilib:tree_jungle_trunk",
        plant_name = "unilib:mushroom_azurea",

        surface_list = {"unilib:dirt_ordinary_with_litter_rainforest"},
    })

end
