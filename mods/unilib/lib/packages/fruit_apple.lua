---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_apple.init()

    return {
        description = "Apple",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_apple.exec()

    unilib.register_node("unilib:fruit_apple", "default:apple", mode, {
        -- From default:apple
        description = S("Apple"),
        tiles = {"unilib_fruit_apple.png"},
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_apple = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_apple.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
        },
        sunlight_propagates = true,
        walkable = false,

        -- N.B. No placer:is_player() check in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_apple", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_apple", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_apple"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_apple",
        juice_description = S("Apple"),
        juice_type = "apple",
        rgb = "#ecff56",

        orig_flag = true,
    })

end

function unilib.pkg.fruit_apple.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_apple",

        replace_mode = mode,
        leaves_list = {"unilib:tree_apple_leaves", "unilib:tree_apple_mature_leaves"},
        orig_name = "default:apple_mark",
        pkg_list = {"tree_apple", "tree_apple_mature"},
    })

end
