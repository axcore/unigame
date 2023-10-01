---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bread
-- Code:    MIT
-- Media:   CC0/CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_pitta = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bread.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_pitta.init()

    return {
        description = "Pitta dough",
        depends = {"ingredient_flour_ordinary", "vessel_glass_water"},
    }

end

function unilib.pkg.ingredient_dough_pitta.exec()

    local c_flour = "unilib:ingredient_flour_ordinary"

    unilib.register_craftitem("unilib:ingredient_dough_pitta", "bread:pita_dough", mode, {
        -- From bread:pita_dough
        description = S("Pitta Dough"),
        inventory_image = "unilib_ingredient_dough_pitta.png",
    })
    unilib.register_craft({
        -- From bread:pita_dough
        output = "unilib:ingredient_dough_pitta",
        recipe = {
            {c_flour, "unilib:vessel_glass_water", c_flour}
        },
    })

end
