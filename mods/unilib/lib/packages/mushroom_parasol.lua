---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_parasol = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_parasol.init()

    return {
        description = "Parasol mushroom",
    }

end

function unilib.pkg.mushroom_parasol.exec()

    unilib.register_node("unilib:mushroom_parasol", "nsspf:macrolepiota_procera", mode, {
        -- From nsspf:macrolepiota_procera
        description = unilib.annotate(S("Parasol Mushroom"), "Macrolepiota procera"),
        tiles = {"unilib_mushroom_parasol.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_parasol.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_parasol", 3),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_macrolepiota_procera
        "unilib:mushroom_parasol_cooked",
        "nsspf:cooked_macrolepiota_procera",
        mode,
        {
            description = S("Cooked Parasol Mushroom"),
            tiles = {"unilib_mushroom_parasol_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_parasol.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
            },

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_parasol_cooked", 16),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_macrolepiota_procera
        type = "cooking",
        output = "unilib:mushroom_parasol_cooked",
        recipe = "unilib:mushroom_parasol",
        cooktime = 10,
    })

    unilib.register_decoration("nsspf_mushroom_parasol", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_parasol",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.nsspf_scarcity_factor,
            seed = 19637,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
