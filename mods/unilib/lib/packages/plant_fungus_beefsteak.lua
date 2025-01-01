---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_beefsteak = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_beefsteak.init()

    return {
        description = "Beefsteak fungus",
        depends = {"shared_nsspf", "tree_pine"},
    }

end

function unilib.pkg.plant_fungus_beefsteak.exec()

    unilib.register_node("unilib:plant_fungus_beefsteak", "nsspf:fistulina_hepatica", mode, {
        -- From nsspf:fistulina_hepatica
        description = unilib.utils.annotate(S("Beefsteak Fungus"), "Fistulina hepatica"),
        tiles = {"unilib_plant_fungus_beefsteak.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_fungus_beefsteak.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_beefsteak", 4),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_fistulina_hepatica
        "unilib:plant_fungus_beefsteak_cooked",
        "nsspf:cooked_fistulina_hepatica",
        mode,
        {
            description = S("Cooked Beefsteak Fungus"),
            tiles = {"unilib_plant_fungus_beefsteak_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
            },
            drawtype = "mesh",
            mesh = "unilib_plant_fungus_beefsteak.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_beefsteak_cooked", 14),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_fistulina_hepatica
        type = "cooking",
        output = "unilib:plant_fungus_beefsteak_cooked",
        recipe = "unilib:plant_fungus_beefsteak",
        cooktime = 10,
    })

    unilib.pkg.shared_nsspf.register_fungus({
        -- Code original to unilib, replacing an ABM in the original code
        wall_name = "unilib:tree_pine_trunk",
        plant_name = "unilib:plant_fungus_beefsteak",

        surface_list = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        dust_list = {"unilib:snow_ordinary"},
    })

end
