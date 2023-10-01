---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pork_pulled = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pork_pulled.init()

    return {
        description = "Pulled pork",
        depends = {"food_bread_ordinary", "ingredient_sauce_barbecue"},
    }

end

function unilib.pkg.food_pork_pulled.exec()

    unilib.register_craftitem("unilib:food_pork_pulled", "bbq:pulled_pork", mode, {
        -- From bbq:pulled_pork
        description = S("Pulled Pork"),
        inventory_image = "unilib_food_pork_pulled.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_pork_pulled", 8),
    })
    unilib.register_craft({
        -- From bbq:pulled_pork
        type = "shapeless",
        output = "unilib:food_pork_pulled 2",
        recipe = {
            "group:food_pork",
            "unilib:food_bread_ordinary",
            "unilib:ingredient_sauce_barbecue",
        },
    })
    unilib.register_external_ingredient("unilib:food_pork_pulled", {
        "group:food_pork",                      -- Originally mobs:pork_cooked
    })

end
