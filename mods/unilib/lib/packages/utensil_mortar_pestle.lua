---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_mortar_pestle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_mortar_pestle.init()

    return {
        description = "Mortar and pestle",
    }

end

function unilib.pkg.utensil_mortar_pestle.exec()

    unilib.register_craftitem("unilib:utensil_mortar_pestle", "farming:mortar_pestle", mode, {
        -- From farming:mortar_pestle
        description = S("Mortar and Pestle"),
        inventory_image = "unilib_utensil_mortar_pestle.png",
        groups = {flammable = 2, food_mortar_pestle = 1}
    })
    unilib.register_craft({
        -- From farming:mortar_pestle
        output = "unilib:utensil_mortar_pestle",
        -- N.B. original code used unilib:stone_ordinary
        recipe = {
            {"group:stone", "group:stick", "group:stone"},
            {"", "group:stone", ""},
        },
    })

end
