---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_lemon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_lemon.init()

    return {
        description = "Lemon",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_lemon.exec()

    unilib.register_node("unilib:fruit_lemon", "ethereal:lemon", mode, {
        -- From ethereal:lemon
        description = S("Lemon"),
        tiles = {"unilib_fruit_lemon.png"},
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_lemon = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_lemon_inv.png",
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
        wield_image = "unilib_fruit_lemon_inv.png",

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_lemon", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_lemon", 3),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_lemon"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_lemon",
        juice_description = S("Lemon"),
        juice_type = "lemon",
        rgb = "#fdf402",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_lemon.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_lemon",

        replace_mode = mode,
        leaves_list = {"unilib:tree_lemon_leaves"},
        pkg_list = {"tree_lemon"},
    })

end
