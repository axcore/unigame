---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_brown.init()

    return {
        description = "Brown mushroom",
        notes = "An edible mushroom",
    }

end

function unilib.pkg.mushroom_brown.exec()

    unilib.register_node("unilib:mushroom_brown", "flowers:mushroom_brown", mode, {
        -- From flowers:mushroom_brown
        description = S("Brown Mushroom"),
        tiles = {"unilib_mushroom_brown.png"},
        groups = {attached_node = 1, flammable = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_brown.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_brown.png",

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_brown", 1),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_brown", "flowers:mushroom_brown")

    unilib.register_decoration("flowers_mushroom_brown", {
        -- From flowers/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_brown",

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
