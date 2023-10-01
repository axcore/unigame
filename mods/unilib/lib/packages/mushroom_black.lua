---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_black.init()

    return {
        description = "Black mushroom",
    }

end

function unilib.pkg.mushroom_black.exec()

    local img = "unilib_mushroom_black.png"

    unilib.register_node("unilib:mushroom_black", "underch:black_mushroom", mode, {
        -- From underch:black_mushroom
        description = S("Black Mushroom"),
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
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,

        -- N.B. Not poisonous, and not nutritious
        on_use = minetest.item_eat(0),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_black")

end
