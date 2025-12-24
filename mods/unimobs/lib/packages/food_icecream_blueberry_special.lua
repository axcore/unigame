---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_blueberry_special = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_blueberry_special.init()

    return {
        description = "Special blueberry ice cream",
        notes = "Name \"special\" to distinguish it from unilib's own blueberry ice cream",
        depends = {"bucket_steel", "crop_wheat", "snow_ordinary"},
        suggested = {
            "fruit_blueberry_ordinary",         -- group:food_blueberries
            "bucket_steel_with_milk_cow",       -- group:food_milk
            "egg_chicken_normal",               -- group:food_egg
        },
    }

end

function unilib.pkg.food_icecream_blueberry_special.exec()

    unilib.register_craftitem(
        -- From petz:blueberry_ice_cream
        "unilib:food_icecream_blueberry_special",
        "petz:blueberry_ice_cream",
        mode,
        {
            description = S("Special Blueberry Ice Cream"),
            inventory_image = "unilib_food_icecream_blueberry_special.png",
            groups = {flammable = 2, food = 2},

            on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_blueberry_special", 7),
        }
    )
    unilib.register_craft({
        -- From petz:blueberry_ice_creamssss
        type = "shapeless",
        output = "unilib:food_icecream_blueberry_special 3",
        recipe = {
            "group:food_blueberries",
            "group:food_milk",
            "group:food_egg",
            "unilib:snow_ordinary",
            "group:food_egg",
            "unilib:snow_ordinary",
            "unilib:crop_wheat_harvest",
        },
        replacements = {
            {"group:food_milk", "unilib:bucket_steel_empty"},
        },
    })

end
