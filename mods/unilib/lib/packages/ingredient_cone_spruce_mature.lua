---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cone_spruce_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cone_spruce_mature.init()

    return {
        description = "Mature spruce tree cone",
        notes = "Grows on mature spruce trees",
    }

end

function unilib.pkg.ingredient_cone_spruce_mature.exec()

    unilib.register_node(
        -- From GLEMr4, lib_ecology:fruit_spruce_cone
        "unilib:ingredient_cone_spruce_mature",
        "lib_ecology:fruit_spruce_cone",
        mode,
        {
            description = S("Mature Spruce Cone"),
            tiles = {"unilib_ingredient_cone_spruce_mature.png"},
            groups = {
                dig_immediate = 3, flammable = 2, fleshy = 3, leafdecay = 1, leafdecay_drop = 1,
            },
            sounds = unilib.sound_table.node,

            drawtype = "plantlike",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
            },
            sunlight_propagates = true,
            visual_scale = 0.8,
            walkable = false,

            after_place_node = function(pos, placer, itemstack)

                if placer:is_player() then

                    minetest.set_node(
                        pos,
                        {name = "unilib:ingredient_cone_spruce_mature", param2 = 1}
                    )

                end

            end,
        }
    )

end

function unilib.pkg.ingredient_cone_spruce_mature.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:ingredient_cone_spruce_mature",

        replace_mode = mode,
        leaves_list = {"unilib:tree_spruce_mature_leaves"},
        pkg_list = {"tree_spruce_mature"},
    })

end
