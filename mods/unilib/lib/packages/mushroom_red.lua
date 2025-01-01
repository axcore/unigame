---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_red.init()

    return {
        description = "Red mushroom",
        notes = "A poisonous mushroom",
    }

end

function unilib.pkg.mushroom_red.exec()

    unilib.register_node("unilib:mushroom_red", "flowers:mushroom_red", mode, {
        -- From flowers:mushroom_red
        description = S("Red Mushroom"),
        tiles = {"unilib_mushroom_red.png"},
        -- N.B. food_mushroom = 1 not in original code
        groups = {attached_node = 1, flammable = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_red.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_red.png",

        -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter for
        --      poisonous foods
        on_use = core.item_eat(-5),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_red", "flowers:mushroom_red")

    unilib.register_decoration_generic("flowers_mushroom_red", {
        -- From flowers/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_red",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
