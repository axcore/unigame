---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_shrimp_boiled = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_shrimp_boiled.init()

    return {
        description = "Boiled shrimp",
        depends = {"flower_fire", "ingredient_fish_basic"},
    }

end

function unilib.pkg.food_fish_shrimp_boiled.exec()

    unilib.register_craftitem(
        -- From ethereal:fish_shrimp_cooked
        "unilib:food_fish_shrimp_boiled",
        "ethereal:fish_shrimp_cooked",
        mode,
        {
            description = S("Boiled Shrimp"),
            inventory_image = "unilib_food_fish_shrimp_boiled.png",
            -- N.B. food_fish = 1, food_shrimp = 1 not in original code
            groups = {flammable = 2, food_fish = 1, food_shrimp = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_fish_shrimp_boiled", 2),
        }
    )

end

function unilib.pkg.food_fish_shrimp_boiled.post()

    local c_fish = "unilib:ingredient_fish_shrimp"

    unilib.register_craft({
        -- From ethereal:fish_shrimp_cooked
        output = "unilib:food_fish_shrimp_boiled 5",
        recipe = {
            {c_fish, c_fish, c_fish},
            {c_fish, "group:potable_bucket", c_fish},
            {"", "unilib:flower_fire_dust", ""},
        },
        replacements = unilib.global.potable_bucket_list,
    })

end

