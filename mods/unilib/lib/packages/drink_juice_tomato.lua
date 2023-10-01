---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_tomato = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_tomato.init()

    return {
        description = "Tomato juice",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.drink_juice_tomato.exec()

    unilib.register_node("unilib:drink_juice_tomato", "better_farming:tomato_juice", mode, {
        -- From better_farming:tomato_juice
        description = S("Tomato Juice"),
        tiles = {"unilib_drink_juice_tomato.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_drink_juice_tomato.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_drink_juice_tomato.png",

        -- N.B. Original code used minetest.item_eat(), and did not return a bottle
        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_juice_tomato", 1, "unilib:vessel_bottle_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From better_farming:tomato_juice
        output = "unilib:drink_juice_tomato",
        -- N.B. Original code used better_farming:tomatoes
        recipe = {
            {"unilib:vessel_bottle_glass_empty", "group:food_tomato"},
        },
    })

end
