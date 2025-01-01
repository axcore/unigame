---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pepper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pepper.init()

    return {
        description = "Red/green/yellow peppers",
        notes = "Produce of various growth stages of the pepper plant",
        optional = "dye_basic",
    }

end

function unilib.pkg.food_pepper.exec()

    unilib.register_craftitem("unilib:food_pepper_green", "farming:pepper", mode, {
        -- From farming:pepper
        description = S("Green Pepper"),
        inventory_image = "unilib_food_pepper_green.png",
        groups = {flammable = 3, food_pepper = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pepper_green", 2),
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:food_pepper_green"},
            },
        })

    end

    unilib.register_craftitem("unilib:food_pepper_yellow", "farming:pepper_yellow", mode, {
        -- From farming:pepper_yellow
        description = S("Yellow Pepper"),
        inventory_image = "unilib_food_pepper_yellow.png",
        groups = {flammable = 3, food_pepper = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pepper_yellow", 3),
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:food_pepper_yellow"},
            },
        })

    end

    unilib.register_craftitem("unilib:food_pepper_red", "farming:pepper_red", mode, {
        -- From farming:pepper_red
        description = S("Red Pepper"),
        inventory_image = "unilib_food_pepper_red.png",
        groups = {flammable = 3, food_pepper = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pepper_red", 4),
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:food_pepper_red"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:food_pepper_green",
        juice_description = S("Pepper"),
        juice_type = "pepper",
        rgb = "#e53200",

        orig_flag = false,
    })
    unilib.juice.register_duplicate("pepper", "unilib:food_pepper_yellow")
    unilib.juice.register_duplicate("pepper", "unilib:food_pepper_red")

end
