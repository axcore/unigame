---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_nightlight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_nightlight.init()

    return {
        description = "Nightlight fungus",
        depends = {"dirt_ordinary", "shared_nsspf"},
    }

end

function unilib.pkg.plant_fungus_nightlight.exec()

    unilib.register_node("unilib:plant_fungus_nightlight", "nsspf:mycena_chlorophos", mode, {
        -- From nsspf:mycena_chlorophos
        description = unilib.utils.annotate(S("Nightlight Fungus"), "Mycena chlorophos"),
        tiles = {"unilib_plant_fungus_nightlight.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_fungus_nightlight.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_nightlight", -2),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_mycena_chlorophos
        "unilib:plant_fungus_nightlight_cooked",
        "nsspf:cooked_mycena_chlorophos",
        mode,
        {
            description = S("Cooked Nightlight Fungus"),
            tiles = {"unilib_plant_fungus_nightlight_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },
            drawtype = "mesh",
            mesh = "unilib_plant_fungus_nightlight.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_nightlight_cooked", -4),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_mycena_chlorophos
        type = "cooking",
        output = "unilib:plant_fungus_nightlight_cooked",
        recipe = "unilib:plant_fungus_nightlight",
        cooktime = 10,
    })

    unilib.register_node(
        -- From nsspf:mycena_chlorophos_light
        "unilib:plant_fungus_nightlight_glowing",
        "nsspf:mycena_chlorophos_light",
        mode,
        {
            description = unilib.utils.annotate(
                S("Glowing Nightlight Fungus"), "Mycena chlorophos"
            ),
            tiles = {"unilib_plant_fungus_nightlight_glowing.png"},
            -- N.B. In original code, only not_in_creative_inventory = 1, snappy = 3
            groups = {
                attached_node = 1, flammable = 1, flora = 1, not_in_creative_inventory = 1,
                snappy = 3,
            },
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },
            drawtype = "mesh",
            drop = "unilib:plant_fungus_nightlight",
            light_source = 8,
            mesh = "unilib_plant_fungus_nightlight.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_nightlight_glowing", -2),
        }
    )

    unilib.pkg.shared_nsspf.register_fungus({
        -- Code original to unilib, replacing an ABM in the original code
        -- N.B. Grows on the side of a dirt node, rather than on a tree node, as usual
        wall_name = "unilib:dirt_ordinary",
        plant_name = "unilib:plant_fungus_nightlight",
    })

    -- (This fungus glows at night)
    unilib.pkg.shared_nsspf.register_glowing("unilib:plant_fungus_nightlight")

end
