---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_pot_cooking = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_pot_cooking.init()

    return {
        description = "Cooking pot",
        depends = "metal_steel",
    }

end

function unilib.pkg.utensil_pot_cooking.exec()

    unilib.register_craftitem("unilib:utensil_pot_cooking", "farming:pot", mode, {
        -- From farming:pot
        description = S("Cooking Pot"),
        inventory_image = "unilib_utensil_pot_cooking.png",
        groups = {flammable = 2, food_pot = 1}
    })
    unilib.register_craft({
        -- From farming:pot
        output = "unilib:utensil_pot_cooking",
        recipe = {
            {"group:stick", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

end
