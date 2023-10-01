---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    chocolate
-- Code:    MIT
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chocolate_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.chocolate.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chocolate_white.init()

    return {
        description = "White chocolate",
        depends = "bucket_steel",
        optional = "ingredient_cocoa_normal",
        suggested = {
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_chocolate_white.exec()

    unilib.register_craftitem("unilib:food_chocolate_white_bar", nil, mode, {
        -- Code original to unilib, texture from "chocolate" mod, chocolate_bar_white.png
        description = S("Bar of White Chocolate"),
        inventory_image = "unilib_food_chocolate_white_bar.png",
        -- N.B. No groups in original code
        groups = {food_chocolate = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_chocolate_white_bar", 5),
    })
    unilib.register_craft( {
        -- Original to unilib, comparable to the craft recipe in the "food_chocolate_dark" package
        output = "unilib:food_chocolate_white 3",
        recipe = {
            {"group:milk_bucket", "group:food_cocoa", "group:milk_bucket"}
        },
        replacements = {
            {"group:milk_bucket", "unilib:bucket_steel_empty"},
            {"group:milk_bucket", "unilib:bucket_steel_empty"},
        },
    })
    if unilib.pkg_executed_table["ingredient_cocoa_normal"] ~= nil then

        unilib.register_craft( {
            -- Original to unilib
            output = "unilib:food_chocolate_milk_bar 3",
            recipe = {
                {"group:milk_bucket", "unilib:ingredient_cocoa_normal_powder", "group:milk_bucket"}
            },
            replacements = {
                {"group:milk_bucket", "unilib:bucket_steel_empty"},
                {"group:milk_bucket", "unilib:bucket_steel_empty"},
            },
        })

    end
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_chocolate_white_bar 9",
        recipe = {
            {"unilib:food_chocolate_white_block"},
        }
    })
    unilib.register_external_ingredient("unilib:food_chocolate_white_bar", {
        "group:milk_bucket",                    -- Originally group:milk_bucket
    })

    unilib.register_node("unilib:food_chocolate_white_block", nil, mode, {
        -- Code original to unilib, texture adapted from farming_redo, farming_chocolate_block.png
        description = S("Block of White Chocolate"),
        tiles = {"unilib_food_chocolate_white_block.png"},
        groups = {cracky = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:food_chocolate_white_block",
        ingredient = "unilib:food_chocolate_white_bar",
    })

end
