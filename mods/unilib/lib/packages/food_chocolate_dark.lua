---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chocolate_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chocolate_dark.init()

    return {
        description = "Dark chocolate",
        optional = "ingredient_cocoa_normal",
        suggested = {
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_chocolate_dark.exec()

    local c_powder = "unilib:ingredient_cocoa_normal_powder"

    unilib.register_craftitem("unilib:food_chocolate_dark_bar", "farming:chocolate_dark", mode, {
        -- Code from farming:chocolate_dark, texture from "chocolate" mod, chocolate_bar_dark.png
        description = S("Bar of Dark Chocolate"),
        inventory_image = "unilib_food_chocolate_dark_bar.png",
        -- N.B. No groups in original code
        groups = {food_chocolate = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_chocolate_dark_bar", 3),
    })
    unilib.register_craft( {
        -- From farming:chocolate_dark
        output = "unilib:food_chocolate_dark_bar",
        recipe = {
            {"group:food_cocoa", "group:food_cocoa", "group:food_cocoa"},
        },
    })
    if unilib.global.pkg_executed_table["ingredient_cocoa_normal"] ~= nil then

        unilib.register_craft( {
            -- Original to unilib
            output = "unilib:food_chocolate_dark_bar",
            recipe = {
                {c_powder, c_powder, c_powder}
            },
        })

    end
    unilib.register_craft({
        -- From farming:chocolate_dark
        output = "unilib:food_chocolate_dark_bar 9",
        recipe = {
            {"unilib:food_chocolate_dark_block"},
        },
    })

    unilib.register_node("unilib:food_chocolate_dark_block", "farming:chocolate_block", mode, {
        -- From farming:chocolate_block
        description = S("Block of Dark Chocolate"),
        tiles = {"unilib_food_chocolate_dark_block.png"},
        groups = {cracky = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From farming:chocolate_block
        output = "unilib:food_chocolate_dark_block",
        ingredient = "unilib:food_chocolate_dark_bar",
    })

end
