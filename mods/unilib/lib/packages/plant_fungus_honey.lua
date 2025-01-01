---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_honey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_honey.init()

    return {
        description = "Honey fungus",
        depends = {"shared_nsspf", "tree_apple"},
    }

end

function unilib.pkg.plant_fungus_honey.exec()

    unilib.register_node("unilib:plant_fungus_honey", "nsspf:armillaria_mellea", mode, {
        -- From nsspf:armillaria_mellea
        description = unilib.utils.annotate(S("Honey Fungus"), "Armillaria mellea"),
        tiles = {"unilib_plant_fungus_honey.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_fungus_honey.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_honey", 2),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_armillaria_mellea
        "unilib:plant_fungus_honey_cooked",
        "nsspf:cooked_armillaria_mellea",
        mode,
        {
            description = S("Cooked Honey Fungus"),
            tiles = {"unilib_plant_fungus_honey_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5},
            },
            drawtype = "mesh",
            mesh = "unilib_plant_fungus_honey.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_honey_cooked", 12),
        }
    )
    unilib.register_craft({
        -- From nsspf:plant_fungus_honey_cooked
        type = "cooking",
        output = "unilib:plant_fungus_honey_cooked",
        recipe = "unilib:plant_fungus_honey",
        cooktime = 10,
    })

    unilib.pkg.shared_nsspf.register_fungus({
        -- Code original to unilib, replacing an ABM in the original code
        wall_name = "unilib:tree_apple_trunk",
        plant_name = "unilib:plant_fungus_honey",

        surface_list = {"unilib:dirt_ordinary_with_turf"},
    })

end
