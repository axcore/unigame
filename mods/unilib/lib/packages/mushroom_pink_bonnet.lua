---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_pink_bonnet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_pink_bonnet.init()

    return {
        description = "Pink bonnet mushroom",
        depends = "tree_jungle",
    }

end

function unilib.pkg.mushroom_pink_bonnet.exec()

    unilib.register_node("unilib:mushroom_pink_bonnet", "nsspf:marasmius_haematocephalus", mode, {
        -- From nsspf:marasmius_haematocephalus
        description = unilib.annotate(S("Pink Bonnet Mushroom"), "Marasmius haematocephalus"),
        tiles = {"unilib_mushroom_pink_bonnet.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_pink_bonnet.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_pink_bonnet", -1),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_marasmius_haematocephalus
        "unilib:mushroom_pink_bonnet_cooked",
        "nsspf:cooked_marasmius_haematocephalus",
        mode,
        {
            description = S("Cooked Pink Bonnet Mushroom"),
            tiles = {"unilib_mushroom_pink_bonnet_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_pink_bonnet.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_pink_bonnet_cooked", -19),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_marasmius_haematocephalus
        type = "cooking",
        output = "unilib:mushroom_pink_bonnet_cooked",
        recipe = "unilib:mushroom_pink_bonnet",
        cooktime = 10,
    })

    -- (This mushroom grows on the top surface of a jungle tree trunk)
    unilib.pkg.shared_nsspf.register_special(
        "unilib:mushroom_pink_bonnet",
        "unilib:tree_jungle_trunk"
    )

end
