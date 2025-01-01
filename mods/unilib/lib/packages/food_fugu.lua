---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fugu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fugu.init()

    return {
        description = "Fugu (prepared pufferfish)",
        notes = "Randomly feeds or poisons the player",
        depends = {
            "ingredient_fish_basic",
            "utensil_board_cutting",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "ingredient_sauce_soy",             -- group:food_soy_sauce
        },
    }

end

function unilib.pkg.food_fugu.exec()

    unilib.register_craftitem("unilib:food_fugu", "ethereal:fugu", mode, {
        -- From ethereal:fugu
        description = S("Fugusashi"),
        inventory_image = "unilib_food_fugu.png",
        -- N.B. food_fugu = 1 not in original code
        groups = {flammable = 2, food_fugu = 1},

        -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter when
        --      a food can be both nutritious and poisonous
        on_use = function(itemstack, user, pointed_thing)

            if user then

                if math.random(12) == 1 then
                    return core.do_item_eat(-16, nil, itemstack, user, pointed_thing)
                else
                    return core.do_item_eat(4, nil, itemstack, user, pointed_thing)
                end

            end

        end,
    })
    unilib.register_craft({
        -- From ethereal:fugu
        output = "unilib:food_fugu",
        recipe = {
            {
                "unilib:utensil_board_cutting",
                "unilib:ingredient_fish_pufferfish",
                "group:food_soy_sauce",
            },
        },
        replacements = {
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
            {"group:food_soy_sauce", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
