---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chocolate_milk = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cacaotree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chocolate_milk.init()

    return {
        description = "Milk chocolate",
        depends = "bucket_steel",
        optional = "ingredient_cocoa_normal",
        suggested = {
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_chocolate_milk.exec()

    local c_powder = "unilib:ingredient_cocoa_normal_powder"

    unilib.register_craftitem("unilib:food_chocolate_milk_bar", "cacaotree:milk_chocolate", mode, {
        -- Code from cacaotree:milk_chocolate, texture from "chocolate" mod, chocolate_bar_milk.png
        description = S("Bar of Milk Chocolate"),
        inventory_image = "unilib_food_chocolate_milk_bar.png",
        -- In original code, also flammable = 2, food = 2,
        groups = {food_chocolate = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_chocolate_milk_bar", 4),
    })
    unilib.register_craft( {
        -- Original to unilib, comparable to the craft recipe in the "food_chocolate_dark" package
        output = "unilib:food_chocolate_milk_bar 3",
        recipe = {
            {"group:food_cocoa", "group:milk_bucket", "group:food_cocoa"},
        },
        replacements = {
            {"group:milk_bucket", "unilib:bucket_steel_empty"},
        },
    })
    if unilib.global.pkg_executed_table["ingredient_cocoa_normal"] ~= nil then

        unilib.register_craft( {
            -- Original to unilib
            output = "unilib:food_chocolate_milk_bar 3",
            recipe = {
                {c_powder, "group:milk_bucket", c_powder}
            },
            replacements = {
                {"group:milk_bucket", "unilib:bucket_steel_empty"},
            },
        })

    end
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_chocolate_milk_bar 9",
        recipe = {
            {"unilib:food_chocolate_milk_block"},
        },
    })
    unilib.register_external_ingredient("unilib:food_chocolate_milk_bar", {
        "group:milk_bucket",                    -- Originally group:milk_bucket
    })

    unilib.register_node("unilib:food_chocolate_milk_block", nil, mode, {
        -- Code original to unilib, texture adapted from farming_redo, farming_chocolate_block.png
        description = S("Block of Milk Chocolate"),
        tiles = {"unilib_food_chocolate_milk_block.png"},
        groups = {cracky = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:food_chocolate_milk_block",
        ingredient = "unilib:food_chocolate_milk_bar",
    })

end
