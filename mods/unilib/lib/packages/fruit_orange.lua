---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_orange.init()

    return {
        description = "Orange fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_orange.exec()

    unilib.register_node("unilib:fruit_orange", "ethereal:orange", mode, {
        -- From ethereal:orange
        description = S("Orange Fruit"),
        tiles = {"unilib_fruit_orange.png"},
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_orange = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_orange.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        place_param2 = 1,
        selection_box = {
            type = "fixed",
            fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_orange.png",

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_orange", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_orange", 4),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:fruit_orange"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_orange",
        juice_description = S("Orange"),
        juice_type = "orange",
        rgb = "#ffc417",

        orig_flag = true,
    })

end

function unilib.pkg.fruit_orange.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_orange",

        replace_mode = mode,
        leaves_list = {"unilib:tree_orange_leaves"},
        pkg_list = {"tree_orange"},
    })

end
