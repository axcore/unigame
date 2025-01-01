---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_bowl_mixing_glass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_bowl_mixing_glass.init()

    return {
        description = "Glass mixing bowl",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.utensil_bowl_mixing_glass.exec()

    unilib.register_craftitem("unilib:utensil_bowl_mixing_glass", "farming:mixing_bowl", mode, {
        -- From farming:mixing_bowl
        description = S("Glass Mixing Bowl"),
        inventory_image = "unilib_utensil_bowl_mixing_glass.png",
        groups = {flammable = 2, food_mixing_bowl = 1}
    })
    unilib.register_craft({
        -- From farming:mixing_bowl
        output = "unilib:utensil_bowl_mixing_glass",
        recipe = {
            {"unilib:glass_ordinary", "group:stick", "unilib:glass_ordinary"},
            {"", "unilib:glass_ordinary", ""},
        },
    })
    unilib.register_craft({
        -- From farming:mixing_bowl
        output = "unilib:glass_ordinary_fragments",
        recipe = {
            {"unilib:utensil_bowl_mixing_glass"},
        },
    })
    -- (Original to unilib)
    unilib.hydration.enable_drinking_from_container("unilib:utensil_bowl_mixing_glass", 25)

end
