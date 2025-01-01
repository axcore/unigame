---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_butter_vegetable = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_butter_vegetable.init()

    return {
        description = "Vegetable butter",
        notes = "Vegetable butter is produced by a milk churn, using the butter preparation" ..
                " as an ingredient",
        depends = {
            "ingredient_cream_coconut",
            "vessel_bottle_glass_empty",
            "vessel_glass_empty",
        },
        at_least_one = {"food_milk_coconut", "food_milk_soy", "food_milk_soy_red"},
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.ingredient_butter_vegetable.exec()

    unilib.register_craftitem(
        -- From cheese:vegetable_butter
        "unilib:ingredient_butter_vegetable",
        "cheese:vegetable_butter",
        mode,
        {
            description = S("Vegetable Butter"),
            inventory_image = "unilib_ingredient_butter_vegetable.png",
            groups = {food_butter = 1, food_vegan = 1, vegan_alternative = 1},
        }
    )

    unilib.register_craftitem(
        -- From cheese:vegetable_butter_prep
        "unilib:ingredient_butter_vegetable_prep",
        "cheese:vegetable_butter_prep",
        mode,
        {
            description = S("Vegetable Butter Preparation"),
            inventory_image = "unilib_ingredient_butter_vegetable_prep.png",
            groups = {vegan_alternative = 1},
        }
    )

end

function unilib.pkg.ingredient_butter_vegetable.post()

    local vegan_milk_list = {}

    if unilib.global.pkg_executed_table["food_milk_soy"] ~= nil then
        table.insert(vegan_milk_list, "unilib:food_milk_soy")
    end

    if unilib.global.pkg_executed_table["food_milk_soy_red"] ~= nil then
        table.insert(vegan_milk_list, "unilib:food_milk_soy_red")
    end

    if unilib.global.pkg_executed_table["food_milk_coconut"] ~= nil then
        table.insert(vegan_milk_list, "unilib:food_milk_coconut")
    end

    for _, milk_name in pairs(vegan_milk_list) do

        unilib.register_craft({
            -- From cheese:vegetable_butter_prep
            type = "shapeless",
            output = "unilib:ingredient_butter_vegetable_prep",
            recipe = {
                "group:food_oil" ,
                "unilib:ingredient_cream_coconut",
                "unilib:ingredient_cream_coconut",
                milk_name,
                milk_name,
            },
            replacements = {
                {milk_name, "unilib:vessel_glass_empty"},
                {milk_name, "unilib:vessel_glass_empty"},
                {"group:food_oil" , "unilib:vessel_bottle_glass_empty"},
            },
        })

    end

end
