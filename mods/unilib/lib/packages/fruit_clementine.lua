---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/clementinetree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_clementine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.clementinetree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_clementine.init()

    return {
        description = "Clementine",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_clementine.exec()

    unilib.register_node("unilib:fruit_clementine", "clementinetree:clementine", mode, {
        -- From clementinetree:clementine
        description = S("Clementine"),
        tiles = {"unilib_fruit_clementine.png"},
        -- N.B. no food_clementine in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_clementine = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_clementine.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,

        -- N.B. No placer:is_player() check in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_clementine", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_clementine", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:fruit_clementine"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_clementine",
        juice_description = S("Clementine"),
        juice_type = "clementine",
        rgb = "#f7ab4f",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_clementine.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_clementine",

        replace_mode = mode,
        leaves_list = {"unilib:tree_clementine_leaves"},
        pkg_list = {"tree_clementine"},
    })

end
