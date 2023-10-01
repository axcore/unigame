---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_green.init()

    return {
        description = "Green mushroom",
    }

end

function unilib.pkg.mushroom_green.exec()

    local img = "unilib_mushroom_green.png"

    unilib.register_node("unilib:mushroom_green", "underch:green_mushroom", mode, {
        -- From underch:green_mushroom
        description = S("Green Mushroom"),
        tiles = {img},
        -- N.B. food_mushroom = 1, mushroom = 1 not in original code
        groups = {attached_node = 1, flammable = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,

        -- N.B. No call to unilib.cuisine_eat_on_use(); checking food history doesn't matter for
        --      poisonous foods
        on_use = minetest.item_eat(-9),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_green", "underch:green_mushroom")

end
