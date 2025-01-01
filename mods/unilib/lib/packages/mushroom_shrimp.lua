---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_shrimp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_shrimp.init()

    return {
        description = "Shrimp mushroom",
    }

end

function unilib.pkg.mushroom_shrimp.exec()

    unilib.register_node("unilib:mushroom_shrimp", "nsspf:russula_xerampelina", mode, {
        -- From nsspf:russula_xerampelina
        description = unilib.utils.annotate(S("Shrimp Mushroom"), "Russula xerampelina"),
        tiles = {"unilib_mushroom_shrimp.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_shrimp.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
        },

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_shrimp", -8),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_russula_xerampelina
        "unilib:mushroom_shrimp_cooked",
        "nsspf:cooked_russula_xerampelina",
        mode,
        {
            description = S("Cooked Shrimp Mushroom"),
            tiles = {"unilib_mushroom_shrimp_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_shrimp.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
            },

            on_use = unilib.cuisine.eat_on_use("unilib:mushroom_shrimp_cooked", 6),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_russula_xerampelina
        type = "cooking",
        output = "unilib:mushroom_shrimp_cooked",
        recipe = "unilib:mushroom_shrimp",
        cooktime = 10,
    })

    unilib.register_decoration_generic("nsspf_mushroom_shrimp", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_shrimp",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.setting.nsspf_scarcity_factor,
            seed = 48692,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
