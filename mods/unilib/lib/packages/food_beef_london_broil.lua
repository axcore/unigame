---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_london_broil = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_london_broil.init()

    return {
        description = "London broil",
        depends = {"food_bacon", "food_beef_normal"},
        suggested = {
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_beef_london_broil.exec()

    unilib.register_craftitem("unilib:food_beef_london_broil_raw", "bbq:london_broil_raw", mode, {
        -- From bbq:london_broil_raw
        description = S("Raw London Broil"),
        inventory_image = "unilib_food_beef_london_broil_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_beef_london_broil_raw", 3),
    })
    unilib.register_craft({
        -- From bbq:london_broil_raw
        type = "shapeless",
        output = "unilib:food_beef_london_broil_raw 2",
        recipe = {"unilib:food_bacon", "group:food_garlic_clove", "unilib:food_beef_normal_raw"},
    })

    unilib.register_craftitem("unilib:food_beef_london_broil", "bbq:london_broil", mode, {
        -- From bbq:london_broil
        description = S("London Broil"),
        inventory_image = "unilib_food_beef_london_broil.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_beef_london_broil", 7),
    })
    unilib.register_craft({
        -- From bbq:london_broil
        type = "cooking",
        output = "unilib:food_beef_london_broil",
        recipe = "unilib:food_beef_london_broil_raw",
        cooktime = 6,
    })

end
