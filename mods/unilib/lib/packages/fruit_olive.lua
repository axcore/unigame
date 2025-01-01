---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_olive = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

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
        -- N.B. no food_olive = 1 in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_olive = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_olive_inv.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        place_param2 = 1,
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_olive_inv.png",
        visual_scale = 0.2,

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_olive", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_olive", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:fruit_olive"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_olive",
        juice_description = S("Olive"),
        juice_type = "olive",
        rgb = "#80ae4b",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_olive.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_olive",

        replace_mode = mode,
        leaves_list = {"unilib:tree_olive_leaves"},
        pkg_list = {"tree_olive"},
    })

end
