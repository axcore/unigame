---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_coffee = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_coffee.init()

    return {
        description = "Cup of coffee",
        depends = {"produce_coffee", "utensil_saucepan_normal", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "produce_coffee",                   -- group:food_coffee
        },
    }

end

function unilib.pkg.drink_cup_coffee.exec()

    unilib.register_node("unilib:drink_cup_coffee", "farming:coffee_cup", mode, {
        -- From farming:coffee_cup
        description = S("Cup of Coffee"),
        tiles = {"unilib_drink_cup_coffee.png"},
        -- N.B. no food_coffee in original code
        groups = {attached_node = 1, dig_immediate = 3, drink = 1, food_coffee = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "torchlike",
        inventory_image = "unilib_drink_cup_coffee.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25},
        },
        walkable = false,
        wield_image = "unilib_drink_cup_coffee.png",

        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_cup_coffee", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_coffee.post()

    local replace_table = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(
        replace_table,
        {"unilib:utensil_saucepan_normal", "unilib:utensil_saucepan_normal"}
    )

    unilib.register_craft({
        -- From farming:coffee_cup
        output = "unilib:drink_cup_coffee",
        recipe = {
            {"unilib:utensil_saucepan_normal", "group:food_coffee", "group:potable_bucket"},
            {"", "unilib:vessel_glass_empty", ""},
        },
        replacements = unilib.potable_bucket_list,
    })

end
