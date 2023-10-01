---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_morel_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_morel_black.init()

    return {
        description = "Black morel mushroom",
    }

end

function unilib.pkg.mushroom_morel_black.exec()

    unilib.register_node("unilib:mushroom_morel_black", "nsspf:morchella_conica", mode, {
        -- From nsspf:morchella_conica
        description = unilib.annotate(S("Black Morel Mushroom"), "Morchella conica"),
        tiles = {"unilib_mushroom_morel_black.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_morel_black.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_morel_black", 2),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_morchella_conica
        "unilib:mushroom_morel_black_cooked",
        "nsspf:cooked_morchella_conica",
        mode,
        {
            description = S("Cooked Black Morel"),
            tiles = {"unilib_mushroom_morel_black_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_morel_black.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15},
            },

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_morel_black_cooked", 8),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_morchella_conica
        type = "cooking",
        output = "unilib:mushroom_morel_black_cooked",
        recipe = "unilib:mushroom_morel_black",
        cooktime = 10,
    })

    unilib.register_decoration("nsspf_mushroom_morel_black", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_morel_black",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.nsspf_scarcity_factor,
            seed = 25907,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
