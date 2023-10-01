---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

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
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:fruit_orange",
        inventory_image = "unilib_fruit_orange.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_orange.png",

        after_place_node = function(pos, placer)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_orange", param2 = 1})
            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_orange", 4),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

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

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_orange",

        replace_mode = mode,
        leaves_list = {"unilib:tree_orange_leaves"},
        pkg_list = {"tree_orange"},
    })

end
