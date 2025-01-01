---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_kohlrabi_roasted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_kohlrabi_roasted.init()

    return {
        description = "Roasted kohlrabi",
        depends = "crop_kohlrabi",
    }

end

function unilib.pkg.food_kohlrabi_roasted.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:kohlrabi_roasted
        "unilib:food_kohlrabi_roasted",
        "cucina_vegana:kohlrabi_roasted",
        mode,
        {
            description = S("Roasted Kohlrabi"),
            inventory_image = "unilib_food_kohlrabi_roasted.png",
            groups = {eatable = 1, food = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_kohlrabi_roasted", 4),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:kohlrabi_roasted
        type = "cooking",
        output = "unilib:food_kohlrabi_roasted",
        recipe = "unilib:crop_kohlrabi_harvest",
        cooktime = 20,
    })
    unilib.register_craft({
        -- From cucina_vegana:kohlrabi_roasted
        type = "fuel",
        recipe = "unilib:food_kohlrabi_roasted",
        burntime = 4,
    })

end
