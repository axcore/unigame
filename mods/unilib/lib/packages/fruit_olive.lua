---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_olive = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_olive.init()

    return {
        description = "Olive",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_olive.exec()

    unilib.register_node("unilib:fruit_olive", "ethereal:olive", mode, {
        -- From ethereal:olive
        description = S("Olive"),
        tiles = {"unilib_fruit_olive.png"},
        -- N.B. no food_olive in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_olive = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:fruit_olive",
        inventory_image = "unilib_fruit_olive_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_olive_inv.png",
        visual_scale = 0.2,

        after_place_node = function(pos, placer)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_olive", param2 = 1})
            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_olive", 1),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:fruit_olive"},
            },
        })

    end

end

function unilib.pkg.fruit_olive.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_olive",

        replace_mode = mode,
        leaves_list = {"unilib:tree_olive_leaves"},
        pkg_list = {"tree_olive"},
    })

end
