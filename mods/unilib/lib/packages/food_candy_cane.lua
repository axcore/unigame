---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_candy_cane = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_candy_cane.init()

    return {
        description = "Candy cane",
        depends = {
            "ingredient_sugar_cane",
            "produce_corn_flint",
            "vessel_bottle_glass_empty",
            "vessel_bottle_glass_water",
        },
    }

end

function unilib.pkg.food_candy_cane.exec()

    unilib.register_craftitem("unilib:food_candy_cane", "better_farming:candy_cane", mode, {
        -- From better_farming:candy_cane
        description = S("Candy Cane"),
        inventory_image = "unilib_food_candy_cane.png",
        groups = {flammable = 2, food_candy = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_candy_cane", 2),
    })
    unilib.register_craft({
        -- From better_farming:candy_cane
        output = "unilib:food_candy_cane",
        recipe = {
            {
                "unilib:ingredient_sugar_cane",
                "unilib:vessel_bottle_glass_water",
                "unilib:produce_corn_flint_harvest",
            },
        },
        -- N.B. No replacements in original code
        replacements = {
            {"unilib:vessel_bottle_glass_water", "unilib:vessel_bottle_glass_empty"},
        },
    })

    unilib.register_node("unilib:food_candy_cane_block", "better_farming:candy_cane_block", mode, {
        -- From better_farming:candy_cane_block
        description = S("Candy Cane Block"),
        tiles = {
            "unilib_food_candy_cane_block_top.png",
            "unilib_food_candy_cane_block_bottom.png",
            "unilib_food_candy_cane_block.png",
        },
        -- N.B. Original code included tree = 1 group
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",
        is_ground_content = false,

        on_place = minetest.rotate_node,
    })
    unilib.register_craft_2x2({
        -- From better_farming:candy_cane_block
        output = "unilib:food_candy_cane_block",
        ingredient = "unilib:food_candy_cane",
    })

end
