---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_milk_soy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_milk_soy.init()

    return {
        description = "Soy milk",
        depends = {"ingredient_extract_vanilla", "vessel_bottle_glass_empty", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "produce_soy_normal",               -- group:food_soy
        },
    }

end

function unilib.pkg.food_milk_soy.exec()

    unilib.register_node("unilib:food_milk_soy", "farming:soy_milk", mode, {
        -- From farming:soy_milk
        description = S("Soy Milk"),
        tiles = {"unilib_food_milk_soy.png"},
        -- N.B. No food_soy_milk in original code
        groups = {
            attached_node = 1, dig_immediate = 3, drink = 1, food_milk_glass = 1, food_soy_milk = 1,
            vessel = 1,
        },
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_milk_soy.png",
        -- N.B. is_ground_content = false not in original code; added to match other food items
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
        wield_image = "unilib_food_milk_soy.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_milk_soy", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.food_milk_soy.post()

    local replace_list = unilib.utils.clone_simple_table(unilib.global.potable_bucket_list)
    table.insert(
        replace_list,
        {"unilib:ingredient_extract_vanilla", "unilib:vessel_bottle_glass_empty"}
    )

    unilib.register_craft({
        -- From farming:soy_milk
        output = "unilib:food_milk_soy",
        recipe = {
            {
                "group:food_soy",
                "group:food_soy",
                "group:food_soy",
            },
            {
                "unilib:ingredient_extract_vanilla",
                "group:potable_bucket",
                "unilib:vessel_glass_empty",
            },
        },
        replacements = replace_list,
    })

end
