---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_salt_bay = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_salt_bay.init()

    return {
        description = "Bay salt",
        depends = {"dye_basic", "food_grass_undersea"},
    }

end

function unilib.pkg.ingredient_salt_bay.exec()

    unilib.register_craftitem("unilib:ingredient_salt_bay", "aqua_farming:salt", mode, {
        -- From aqua_farming:salt
        description = S("Bay Salt"),
        groups = {food = 1, food_salt = 1, food_vegan = 1},
        inventory_image = "unilib_ingredient_salt_bay.png",
    })
    unilib.register_craft({
        -- From aqua_farming:salt
        type = "shapeless",
        output = "unilib:ingredient_salt_bay",
        recipe = {"unilib:food_grass_undersea_roasted"},
        replacements = {
            {"unilib:food_grass_undersea_roasted", "unilib:dye_green_dark"},
        },
    })

end
