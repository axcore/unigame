---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_honey_dandelion = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_honey_dandelion.init()

    return {
        description = "Dandelion honey",
        depends = {
            "crop_cotton",
            "food_hotpot_dandelion",
            "vessel_bottle_glass_empty",
            "wool_basic",
        },
    }

end

function unilib.pkg.food_honey_dandelion.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:dandelion_honey
        "unilib:food_honey_dandelion",
        "cucina_vegana:dandelion_honey",
        mode,
        {
            description = S("Dandelion Honey"),
            inventory_image = "unilib_food_honey_dandelion.png",
            groups = {eatable = 1, flammable = 1, food = 1, food_honey = 1, food_sugar = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_honey_dandelion", 3),
        }
    )

end

function unilib.pkg.food_honey_dandelion.post()

    local replace_table = { {"group:wool", "unilib:crop_cotton_harvest 2"} }
    if unilib.global.fallback_empty_bucket ~= nil then

        table.insert(
            replace_table,
            {"unilib:food_hotpot_dandelion_cooked", unilib.global.fallback_empty_bucket}
        )

    end

    unilib.register_craft({
        -- From cucina_vegana:dandelion_honey
        output = "unilib:food_honey_dandelion",
        recipe = {
            {"unilib:food_hotpot_dandelion_cooked", "", ""},
            {"group:wool", "", ""},
            {"unilib:vessel_bottle_glass_empty", "", ""},
        },
--      replacements = {
--          {"unilib:food_hotpot_dandelion_cooked", unilib.global.fallback_empty_bucket},
--          {"group:wool", "unilib:crop_cotton_harvest 2"},
--      },
        replacements = replace_table,
    })

end
