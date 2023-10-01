---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_lemon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

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
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:fruit_lemon",
        inventory_image = "unilib_fruit_lemon_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_lemon_inv.png",

        after_place_node = function(pos, placer)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_lemon", param2 = 1})
            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_lemon", 3),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_lemon"},
            },
        })

    end

end

function unilib.pkg.fruit_lemon.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_lemon",

        replace_mode = mode,
        leaves_list = {"unilib:tree_lemon_leaves"},
        pkg_list = {"tree_lemon"},
    })

end
