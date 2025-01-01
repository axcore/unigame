---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_smoothie_triple_berry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_smoothie_triple_berry.init()

    return {
        description = "Triple berry smoothie",
        depends = "vessel_glass_empty",
        suggested = {
            "fruit_banana",                     -- group:food_banana
            "produce_blackberry",               -- group:food_blackberries
            "produce_raspberry",                -- group:food_raspberries
            "produce_strawberry_normal",        -- group:food_strawberry
        },
    }

end

function unilib.pkg.food_smoothie_triple_berry.exec()

    unilib.register_craftitem("unilib:food_smoothie_triple_berry", "farming:smoothie_berry", mode, {
        -- From farming:smoothie_berry
        description = S("Triple Berry Smoothie"),
        inventory_image = "unilib_food_smoothie_triple_berry.png",
        -- N.B. no food_banana in original code
        groups = {drink = 1, food_berry_smoothie = 1, vessel = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_smoothie_triple_berry", 6, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From farming:smoothie_berry
        type = "shapeless",
        output = "farming:smoothie_berry",
        recipe = {
            "group:food_raspberries",
            "group:food_blackberries",
            "group:food_strawberry",
            "group:food_banana",
            "unilib:vessel_glass_empty",
        },
    })

end
