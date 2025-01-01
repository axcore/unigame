---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_orange.init()

    return {
        description = "Orange mushroom",
    }

end

function unilib.pkg.mushroom_orange.exec()

    local img = "unilib_mushroom_orange.png"

    unilib.register_node("unilib:mushroom_orange", "underch:orange_mushroom", mode, {
        -- From underch:orange_mushroom
        description = S("Orange Mushroom"),
        tiles = {img},
        -- N.B. food_mushroom = 1, mushroom = 1 not in original code
        groups = {attached_node = 1, flammable = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 7 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_orange", 1),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_orange", "underch:orange_mushroom")

    unilib.register_decoration_spare("unilib:mushroom_orange")

end
