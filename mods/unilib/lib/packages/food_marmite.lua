---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_marmite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local c_bottle = "unilib:vessel_bottle_glass_empty"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_eat(itemstack, user, pointed_thing, satiation)

    local marmite_mode = unilib.utils.get_player_attribute(user, "marmite_mode")
    if marmite_mode ~= "tasty" and marmite_mode ~= "poison" then

        -- First consumption of marmite by this player. You either love it, or you hate it...
        if math.random(2) == 1 then
            marmite_mode = "tasty"
        else
            marmite_mode = "poison"
        end

        unilib.utils.set_player_attribute(user, "marmite_mode", marmite_mode)

    end

    local return_func
    if marmite_mode == "tasty" then

        return_func = unilib.cuisine.eat_on_use("unilib:food_marmite", satiation, c_bottle)

    else

        -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter for
        --      poisonous foods
        return_func = core.item_eat((satiation * -1), c_bottle)

    end

    return_func(itemstack, user, pointed_thing)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_marmite.init()

    return {
        description = "Marmite",
        notes = "Poisonous for 50% of players, chosen at random",
        depends = {"crop_wheat", "mushroom_brown", "vessel_bottle_glass_empty"},
        optional = "food_bread_toast",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_sugar_normal",          -- group:food_sugar
            "ingredient_yeast",                 -- group:food_yeast
        },
    }

end

function unilib.pkg.food_marmite.exec()

    unilib.register_craftitem("unilib:food_marmite", nil, mode, {
        -- Original to unilib
        description = S("Marmite"),
        inventory_image = "unilib_food_marmite.png",
        groups = {flammable = 2, food_marmite = 1},

        on_use = function(itemstack, user, pointed_thing)
            do_eat(itemstack, user, pointed_thing, 2)
        end,
    })

    if unilib.global.pkg_executed_table["food_bread_toast"] ~= nil then

        -- N.B. Marmite on toast is here, rather than in a separate package, so we don't have to
        --      duplicate (or share) the do_eat() function
        unilib.register_craftitem("unilib:food_bread_toast_marmite", nil, mode, {
            -- Original to unilib
            description = S("Marmite on Toast"),
            inventory_image = "unilib_food_bread_toast_marmite.png",
            groups = {flammable = 2, food_toast_marmite = 1, food_toast = 1},

            on_use = function(itemstack, user, pointed_thing)
                do_eat(itemstack, user, pointed_thing, 4)
            end,
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:food_bread_toast_marmite",
            recipe = {
                {"unilib:food_marmite"},
                {"unilib:food_bread_toast"},
            },
        })

    end

end

function unilib.pkg.food_marmite.post()

    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_marmite 2",
        recipe = {
            {"unilib:crop_wheat_harvest", "group:food_yeast", "unilib:crop_wheat_harvest"},
            {"unilib:mushroom_brown", "group:food_sugar", "unilib:mushroom_brown"},
            {c_bottle, "group:potable_bucket", c_bottle},
        },
        replacements = unilib.global.potable_bucket_list,
    })

end
