---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_tofu_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_tofu_red.init()

    return {
        description = "Red tofu",
        depends = "crop_soy_red",
    }

end

function unilib.pkg.food_tofu_red.exec()

    unilib.register_craftitem("unilib:food_tofu_red_raw", "cucina_vegana:tofu", mode, {
        -- From cucina_vegana:tofu
        description = S("Red Tofu"),
        inventory_image = "unilib_food_tofu_red_raw.png",
        groups = {eatable = 1, flammable = 1, food = 1, food_vegan = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_tofu_red_raw", 2),
    })
    unilib.register_craft_3x3({
        -- From cucina_vegana:tofu
        output = "unilib:food_tofu_red_raw",
        ingredient = "unilib:crop_soy_red_harvest",
    })

    unilib.register_craftitem("unilib:food_tofu_red_cooked", "cucina_vegana:tofu_cooked", mode, {
        -- From cucina_vegana:tofu
        description = S("Cooked Red Tofu"),
        inventory_image = "unilib_food_tofu_red_cooked.png",
        groups = {eatable = 1, flammable = 1, food = 1, food_tofu = 1, food_vegan = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_tofu_red_cooked", 3),
    })
    unilib.register_craft({
        -- From cucina_vegana:tofu
        type = "cooking",
        output = "unilib:food_tofu_red_cooked",
        recipe = "unilib:food_tofu_red_raw",
        cooktime = 5,
    })
    if unilib.technic_extra_flag then

        technic.register_compressor_recipe({
            -- From cucina_vegana:tofu
            output = "unilib:food_tofu_red_raw",
            input = {"unilib:crop_soy_red_harvest 8"},
        })

    end

end
