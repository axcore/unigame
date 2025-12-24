---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_muffin_blueberry_special = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_muffin_blueberry_special.init()

    return {
        description = "Special blueberry muffin",
        notes = "Name \"special\" to distinguish it from unilib's own blueberry muffin",
        depends = {"bucket_steel", "crop_wheat", "item_paper_ordinary"},
        suggested = {
            "bucket_steel_with_milk_cow",       -- group:food_milk
            "egg_chicken_normal",               -- group:food_egg
            "fruit_blueberry_ordinary",         -- group:food_blueberries
        },
    }

end

function unilib.pkg.food_muffin_blueberry_special.exec()

    unilib.register_craftitem(
        -- From petz:blueberry_muffin
        "unilib:food_muffin_blueberry_special",
        "petz:blueberry_muffin",
        mode,
        {
            description = S("Special Blueberry Muffin"),
            inventory_image = "unilib_food_muffin_blueberry_special.png",
            groups = {flammable = 2, food = 2},

            on_use = unilib.cuisine.eat_on_use("unilib:food_muffin_blueberry_special", 4),
        }
    )
    unilib.register_craft({
        -- From petz:blueberry_muffin
        type = "shapeless",
        output = "unilib:food_muffin_blueberry_special 8",
        recipe = {
            "group:food_blueberries",
            "unilib:crop_wheat_harvest",
            "unilib:crop_wheat_harvest",
            "group:food_egg",
            "group:food_egg",
            "unilib:item_paper_ordinary",
            "group:food_milk",
        },
        replacements = {
            {"group:food_milk", "unilib:bucket_steel_empty"},
        },
    })

end
