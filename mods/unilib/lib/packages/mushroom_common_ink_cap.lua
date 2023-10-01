---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_common_ink_cap = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_common_ink_cap.init()

    return {
        description = "Common ink cap mushroom",
    }

end

function unilib.pkg.mushroom_common_ink_cap.exec()

    unilib.register_node("unilib:mushroom_common_ink_cap", "nsspf:coprinus_atramentarius", mode, {
        -- From nsspf:coprinus_atramentarius
        description = unilib.annotate(S("Common Ink Cap Mushroom"), "Coprinus atramentarius"),
        tiles = {"unilib_mushroom_common_ink_cap.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_common_ink_cap.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_common_ink_cap", -13),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_coprinus_atramentarius
        "unilib:mushroom_common_ink_cap_cooked",
        "nsspf:cooked_coprinus_atramentarius",
        mode,
        {
            description = S("Cooked Common Ink Cap Mushroom"),
            tiles = {"unilib_mushroom_common_ink_cap_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_common_ink_cap.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
            },

            on_use = unilib.cuisine_eat_on_use("unilib:mushroom_common_ink_cap_cooked", 6),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_coprinus_atramentarius
        type = "cooking",
        output = "unilib:mushroom_common_ink_cap_cooked",
        recipe = "unilib:mushroom_common_ink_cap",
        cooktime = 10,
    })

    unilib.register_decoration("nsspf_mushroom_common_ink_cap", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_common_ink_cap",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.nsspf_scarcity_factor,
            seed = 16588,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
