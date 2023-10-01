---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_seed_sunflower_toasted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_seed_sunflower_toasted.init()

    return {
        description = "Toasted sunflower seeds",
        depends = "crop_sunflower_giant",
    }

end

function unilib.pkg.food_seed_sunflower_toasted.exec()

    unilib.register_craftitem(
        -- From farming:sunflower_seeds_toasted
        "unilib:food_seed_sunflower_toasted",
        "farming:sunflower_seeds_toasted",
        mode,
        {
            description = S("Toasted Sunflower Seeds"),
            inventory_image = "unilib_food_seed_sunflower_toasted.png",
            groups = {flammable = 2, food_sunflower_seeds_toasted = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_seed_sunflower_toasted", 1),
        }
    )
    unilib.register_craft({
        -- From farming:sunflower_seeds_toasted
        type = "cooking",
        output = "unilib:food_seed_sunflower_toasted",
        recipe = "unilib:crop_sunflower_giant_seed",
        cooktime = 10,
    })

end
