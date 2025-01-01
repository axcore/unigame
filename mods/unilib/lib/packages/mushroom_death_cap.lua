---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_death_cap = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_death_cap.init()

    return {
        description = "Death cap mushroom",
    }

end

function unilib.pkg.mushroom_death_cap.exec()

    unilib.register_node("unilib:mushroom_death_cap", "nsspf:amanita_phalloides", mode, {
        -- From nsspf:amanita_phalloides
        description = unilib.utils.annotate(S("Death Cap Mushroom"), "Amanita phalloides"),
        tiles = {"unilib_mushroom_death_cap.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
        },
        drawtype = "mesh",
        mesh = "unilib_mushroom_amanita.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
        },

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_death_cap", -20),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_amanita_phalloides
        "unilib:mushroom_death_cap_cooked",
        "nsspf:cooked_amanita_phalloides",
        mode,
        {
            description = S("Cooked Death Cap Mushroom"),
            tiles = {"unilib_mushroom_death_cap_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
            },
            drawtype = "mesh",
            mesh = "unilib_mushroom_amanita.b3d",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05},
            },

            on_use = unilib.cuisine.eat_on_use("unilib:mushroom_death_cap_cooked", -20),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_amanita_phalloides
        type = "cooking",
        output = "unilib:mushroom_death_cap_cooked",
        recipe = "unilib:mushroom_death_cap",
        cooktime = 10,
    })

    unilib.register_decoration_generic("nsspf_mushroom_death_cap", {
        -- Adapted from flowers:mushroom_brown, replacing the collection of ABMs in the original
        --      nsspf code
        deco_type = "simple",
        decoration = "unilib:mushroom_death_cap",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006 / unilib.setting.nsspf_scarcity_factor,
            seed = 11763,      -- New random seed, generated for unilib
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
