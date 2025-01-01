---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_white_snowbank = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_white_snowbank.init()

    return {
        description = "White snowbank mushroom",
    }

end

function unilib.pkg.mushroom_white_snowbank.exec()

    unilib.register_node("unilib:mushroom_white_snowbank", "nsspf:clitocybe_glacialis", mode, {
        -- From nsspf:clitocybe_glacialis
        description = unilib.utils.annotate(S("White Snowbank Mushroom"), "Clitocybe glacialis"),
        tiles = {"unilib_mushroom_white_snowbank.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_white_snowbank.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
        },

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_white_snowbank", 1),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_clitocybe_glacialis
        "unilib:mushroom_white_snowbank_cooked",
        "nsspf:cooked_clitocybe_glacialis",
        mode,
        {
            description = S("Cooked White Snowbank Mushroom"),
            tiles = {"unilib_mushroom_white_snowbank_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_white_snowbank.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05},
            },

            on_use = unilib.cuisine.eat_on_use("unilib:mushroom_white_snowbank_cooked", 10),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_clitocybe_glacialis
        type = "cooking",
        output = "unilib:mushroom_white_snowbank_cooked",
        recipe = "unilib:mushroom_white_snowbank",
        cooktime = 10,
    })

    unilib.register_decoration_generic("nsspf_mushroom_white_snowbank", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_white_snowbank",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.setting.nsspf_scarcity_factor,
            seed = 64859,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
