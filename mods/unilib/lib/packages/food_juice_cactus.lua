---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_juice_cactus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_juice_cactus.init()

    return {
        description = "Cactus juice",
        notes = "Either improves the player's health, or reduces it a little",
        depends = {"plant_cactus_ordinary", "utensil_juicer_normal", "vessel_glass_empty"},
    }

end

function unilib.pkg.food_juice_cactus.exec()

    unilib.register_craftitem("unilib:food_juice_cactus", "farming:cactus_juice", mode, {
        -- From farming:cactus_juice
        description = S("Cactus Juice"),
        inventory_image = "unilib_food_juice_cactus.png",
        -- N.B. no food_cactus in original code
        groups = {drink = 1, food_cactus = 1, vessel = 1},

        -- N.B. No call to unilib.cuisine_eat_on_use(); checking food history doesn't matter when
        --      a food can be both nutritious and poisonous
        on_use = function(itemstack, user, pointed_thing)

            if user then

                if math.random(5) == 1 then

                    return minetest.do_item_eat(
                        -1, "unilib:vessel_glass_empty", itemstack, user, pointed_thing
                    )

                else

                    return minetest.do_item_eat(
                        2, "unilib:vessel_glass_empty", itemstack, user, pointed_thing
                    )

                end

            end

        end,
    })
    unilib.register_craft({
        -- From farming:cactus_juice
        output = "unilib:food_juice_cactus",
        recipe = {
            {"unilib:plant_cactus_ordinary"},
            {"unilib:utensil_juicer_normal"},
            {"unilib:vessel_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_juicer_normal", "unilib:utensil_juicer_normal"},
        },
    })

end
