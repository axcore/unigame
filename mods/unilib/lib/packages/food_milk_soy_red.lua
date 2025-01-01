---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_milk_soy_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_milk_soy_red.init()

    return {
        description = "Red soybean milk",
        depends = {"crop_soy_red", "vessel_glass_empty"},
    }

end

function unilib.pkg.food_milk_soy_red.exec()

    local c_soy = "unilib:crop_soy_red_harvest"

    unilib.register_craftitem("unilib:food_milk_soy_red", "cucina_vegana:soy_milk", mode, {
        -- From cucina_vegana:soy_milk
        description = S("Red Soybean Milk"),
        inventory_image = "unilib_food_milk_soy_red.png",
        -- N.B. replaced original food_milk = 1 from original code, with food_milk_glass = 1
        -- N.B. no food_soy_milk in original code
        groups = {
            eatable = 1, flammable = 1, food = 1, food_milk_glass = 1, food_soy_milk = 1,
            food_vegan = 1,
        },

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_milk_soy_red", 1, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:soy_milk
        output = "unilib:food_milk_soy_red",
        recipe = {
            {c_soy, c_soy, c_soy},
            {"", c_soy, ""},
            {"", "unilib:vessel_glass_empty", ""},
        },
    })

    if unilib.setting.technic_extra_flag then

        technic.register_extractor_recipe({
            -- From cucina_vegana:soy_milk
            output = "unilib:food_milk_soy_red",
            input = {"unilib:crop_soy_red_harvest 4"},
        })

    end

end
