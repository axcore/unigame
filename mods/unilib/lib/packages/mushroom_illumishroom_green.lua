---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_illumishroom_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_illumishroom_green.init()

    return {
        description = "Green illumishroom",
    }

end

function unilib.pkg.mushroom_illumishroom_green.exec()

    unilib.register_node("unilib:mushroom_illumishroom_green", "ethereal:illumishroom2", mode, {
        -- From ethereal:illumishroom2
        description = S("Green Illumishroom"),
        tiles = {"unilib_mushroom_illumishroom_green.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {attached_node = 1, dig_immediate = 3, flammable = 3, mushroom = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_illumishroom_green.png",
        light_source = 5,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.47, 6 / 16}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_illumishroom_green.png",
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_illumishroom_green", "ethereal:illumishroom2")

end
