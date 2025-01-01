---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cheese_stretched = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cheese_stretched.init()

    return {
        description = "Stretched cheese (ingredient)",
        depends = "ingredient_curd",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_salt_normal",           -- group:food_salt
        },
    }

end

function unilib.pkg.ingredient_cheese_stretched.exec()

    unilib.register_craftitem(
        -- From cheese:stretched_cheese
        "unilib:ingredient_cheese_stretched",
        "cheese:stretched_cheese",
        mode,
        {
            description = S("Stretched Cheese"),
            inventory_image = "unilib_ingredient_cheese_stretched.png",
            groups = {milk_product = 1},
        }
    )

end

function unilib.pkg.ingredient_cheese_stretched.post()

    local c_curd = "unilib:ingredient_curd"

    unilib.register_craft({
        -- From cheese:stretched_cheese
        type = "shapeless",
        output = "unilib:ingredient_cheese_stretched 4",
        recipe = {c_curd, c_curd, c_curd, "group:potable_bucket", "group:food_salt"},
        replacements = unilib.global.potable_bucket_list,
    })

end
