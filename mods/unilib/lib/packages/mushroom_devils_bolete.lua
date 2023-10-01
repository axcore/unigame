---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_devils_bolete = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_devils_bolete.init()

    return {
        description = "Devil's bolete mushroom",
    }

end

function unilib.pkg.mushroom_devils_bolete.exec()

    unilib.register_node("unilib:mushroom_devils_bolete", "nsspf:boletus_satanas", mode, {
        -- From nsspf:boletus_satanas
        -- N.B. According to Wikipedia, scientifica name updated in 2014
        description = unilib.annotate(S("Devil's Bolete Mushroom"), "Rubroboletus satanas"),
        tiles = {"unilib_mushroom_devils_bolete.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_bolete.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_devils_bolete", -20),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_boletus_satanas
        "unilib:mushroom_devils_bolete_cooked",
        "nsspf:cooked_boletus_satanas",
        mode,
        {
            description = S("Cooked Devil's Bolete"),
            tiles = {"unilib_mushroom_devils_bolete_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_bolete.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28},
            },

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_devils_bolete_cooked", -16),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_boletus_satanas
        type = "cooking",
        output = "unilib:mushroom_devils_bolete_cooked",
        recipe = "unilib:mushroom_devils_bolete",
        cooktime = 10,
    })

    unilib.register_decoration("nsspf_mushroom_devils_bolete", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_devils_bolete",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.nsspf_scarcity_factor,
            seed = 52166,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
