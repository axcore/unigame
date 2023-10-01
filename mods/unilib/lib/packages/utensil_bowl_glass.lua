---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_bowl_glass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_bowl_glass.init()

    return {
        description = "Glass bowl",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.utensil_bowl_glass.exec()

    unilib.register_node("unilib:utensil_bowl_glass", "cucina_vegana:bowl", mode, {
        -- From cucina_vegana:bowl
        description = S("Glass Bowl"),
        tiles = {"unilib_utensil_bowl_glass.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_bowl = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_utensil_bowl_glass.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_utensil_bowl_glass.png",
    })
    unilib.register_craft({
        -- From cucina_vegana:bowl
        output = "unilib:utensil_bowl_glass 5",
        recipe = {
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
            {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
        },
    })

end
