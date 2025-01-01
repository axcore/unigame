---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_fig_moreton_bay = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_fig_moreton_bay.init()

    return {
        description = "Moreton bay fig",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_fig_moreton_bay.exec()

    unilib.register_node("unilib:fruit_fig_moreton_bay", "australia:moreton_bay_fig", mode, {
        -- From australia:moreton_bay_fig
        description = S("Moreton Bay Fig"),
        tiles = {"unilib_fruit_fig_moreton_bay.png"},
        -- N.B. no food_fig in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_fig = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_fig_moreton_bay.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.67,
        walkable = false,
        wield_image = "unilib_fruit_fig_moreton_bay.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_fig_moreton_bay", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_fig_moreton_bay", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_magenta",
            recipe = {
                {"unilib:fruit_fig_moreton_bay"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_fig_moreton_bay",
        juice_description = S("Fig"),
        juice_type = "fig",
        rgb = "#b04d66",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_fig_moreton_bay.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_fig_moreton_bay",

        replace_mode = mode,
        leaves_list = {"unilib:tree_fig_moreton_bay_leaves"},
        pkg_list = {"tree_fig_moreton_bay"},
    })

end
