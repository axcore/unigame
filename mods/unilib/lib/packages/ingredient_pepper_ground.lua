---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_pepper_ground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_pepper_ground.init()

    return {
        description = "Ground pepper",
        depends = {"utensil_mortar_pestle", "vessel_bottle_glass_empty"},
        suggested = {
            "produce_pepper",                   -- group:food_peppercorn
        },

    }

end

function unilib.pkg.ingredient_pepper_ground.exec()

    unilib.register_node("unilib:ingredient_pepper_ground", "farming:pepper_ground", mode, {
        -- From farming:pepper_ground
        description = S("Ground Pepper"),
        tiles = {"unilib_ingredient_pepper_ground.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_pepper_ground = 1, vessel = 1},
        sounds = unilib.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_pepper_ground.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        visual_scale = 0.80,
        wield_image = "unilib_ingredient_pepper_ground.png",
    })
    unilib.register_craft({
        -- From farming:pepper_ground
        output = "unilib:ingredient_pepper_ground",
        recipe = {
            {"group:food_peppercorn"},
            {"unilib:utensil_mortar_pestle"},
            {"unilib:vessel_bottle_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
        },
    })

end
