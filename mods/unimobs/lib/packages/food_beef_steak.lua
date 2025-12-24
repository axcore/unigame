---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_steak = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_steak.init()

    return {
        description = "Beefsteak",
    }

end

function unilib.pkg.food_beef_steak.exec()

    unilib.register_craftitem("unilib:food_beef_steak_raw", "petz:beef", mode, {
        -- From petz:beef
        description = S("Raw Beeksteak"),
        inventory_image = "unilib_food_beef_steak_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_beef_steak_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_beef_steak_raw", 1),
    })

    unilib.register_craftitem("unilib:food_beef_steak_cooked", "petz:steak", mode, {
        -- From petz:steak
        description = S("Beefsteak"),
        inventory_image = "unilib_food_beef_steak_cooked.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_beef_steak_cooked", 3),
    })
    unilib.register_craft({
        -- From petz:steak
        type = "cooking",
        output = "unilib:food_beef_steak_cooked",
        recipe = "unilib:food_beef_steak_raw",
        cooktime = 2,
    })

end
