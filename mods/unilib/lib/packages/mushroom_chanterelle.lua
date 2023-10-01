---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_chanterelle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_chanterelle.init()

    return {
        description = "Chanterelle mushroom",
    }

end

function unilib.pkg.mushroom_chanterelle.exec()

    unilib.register_node("unilib:mushroom_chanterelle", "nsspf:cantharellus_cibarius", mode, {
        -- From nsspf:cantharellus_cibarius
        description = unilib.annotate(S("Chanterelle Mushroom"), "Cantharellus cibarius"),
        tiles = {"unilib_mushroom_chanterelle.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_chanterelle.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_chanterelle", 1),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_cantharellus_cibarius
        "unilib:mushroom_chanterelle_cooked",
        "nsspf:cooked_cantharellus_cibarius",
        mode,
        {
            description = S("Cooked Chanterelle Mushroom"),
            tiles = {"unilib_mushroom_chanterelle_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_chanterelle.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28},
            },

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_chanterelle_cooked", 8),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_cantharellus_cibarius
        type = "cooking",
        output = "unilib:mushroom_chanterelle_cooked",
        recipe = "unilib:mushroom_chanterelle",
        cooktime = 10,
    })

    unilib.register_decoration("nsspf_mushroom_chanterelle", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_chanterelle",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.nsspf_scarcity_factor,
            seed = 56791,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
