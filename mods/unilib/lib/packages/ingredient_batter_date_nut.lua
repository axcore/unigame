---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_batter_date_nut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_batter_date_nut.init()

    return {
        description = "Date and nut cake batter",
        depends = {
            "food_milk_coconut",
            "food_snack_date_nut",
            "fruit_coconut",
            "vessel_glass_empty",
        },
        at_least_one = {"ingredient_batter_muffin_acorn", "ingredient_flour_ordinary"},
    }

end

function unilib.pkg.ingredient_batter_date_nut.exec()

    local flour_list = {}
    if unilib.global.pkg_executed_table["ingredient_batter_muffin_acorn"] ~= nil then
        table.insert(flour_list, "unilib:ingredient_batter_muffin_acorn")
    end

    if unilib.global.pkg_executed_table["ingredient_flour_ordinary"] ~= nil then
        table.insert(flour_list, "unilib:ingredient_flour_ordinary")
    end

    unilib.register_craftitem(
        -- From moretrees:date_nut_batter
        "unilib:ingredient_batter_date_nut",
        "moretrees:date_nut_batter",
        mode,
        {
            description = S("Date and Nut Cake Batter"),
            inventory_image = "unilib_ingredient_batter_date_nut.png",
        }
    )
    for _, flour_name in ipairs(flour_list) do

        unilib.register_craft({
            -- From moretrees:date_nut_batter
            type = "shapeless",
            output = "unilib:ingredient_batter_date_nut",
            recipe = {
                "unilib:food_snack_date_nut",
                "unilib:food_snack_date_nut",
                "unilib:food_snack_date_nut",
                "unilib:food_milk_coconut",
                "unilib:food_snack_date_nut",
                "unilib:fruit_coconut_slice",
                "unilib:food_milk_coconut",
                flour_name,
                "unilib:fruit_coconut_slice",
            },
            replacements = {
                {"unilib:food_milk_coconut", "unilib:vessel_glass_empty 2"},
            },
        })

    end

end
