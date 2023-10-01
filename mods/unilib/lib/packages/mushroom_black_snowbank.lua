---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_black_snowbank = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_black_snowbank.init()

    return {
        description = "Black snowbank mushroom",
    }

end

function unilib.pkg.mushroom_black_snowbank.exec()

    unilib.register_node("unilib:mushroom_black_snowbank", "nsspf:plectania_nannfeldtii", mode, {
        -- From nsspf:plectania_nannfeldtii
        description = unilib.annotate(S("Black Snowbank Mushroom"), "Plectania nannfeldtii"),
        tiles = {"unilib_mushroom_black_snowbank.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_black_snowbank.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_black_snowbank", -20),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_plectania_nannfeldtii
        "unilib:mushroom_black_snowbank_cooked",
        "nsspf:cooked_plectania_nannfeldtii",
        mode,
        {
            description = S("Cooked Black Snowbank Mushroom"),
            tiles = {"unilib_mushroom_black_snowbank_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_black_snowbank.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3},
            },

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_black_snowbank_cooked", -20),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_plectania_nannfeldtii
        type = "cooking",
        output = "unilib:mushroom_black_snowbank_cooked",
        recipe = "unilib:mushroom_black_snowbank",
        cooktime = 10,
    })

    unilib.register_decoration("nsspf_mushroom_black_snowbank", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_black_snowbank",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.nsspf_scarcity_factor,
            seed = 52028,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
