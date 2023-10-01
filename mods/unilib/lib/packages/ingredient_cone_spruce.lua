---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cone_spruce = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cone_spruce.init()

    return {
        description = "Spruce cone",
        notes = "Grows on spruce trees",
    }

end

function unilib.pkg.ingredient_cone_spruce.exec()

    -- (Regrowing fruit will not work if attached_node group set)
    local group_table = {
        attached_node = 1, dig_immediate = 3, flammable = 2, fleshy = 3, leafdecay = 1,
        leafdecay_drop = 1,
    }
    if unilib.regrow_fruit_flag then
        group_table.attached_node = nil
    end

    unilib.register_node("unilib:ingredient_cone_spruce", "moretrees:spruce_cone", mode, {
        -- From moretrees:spruce_cone
        description = S("Spruce Cone"),
        tiles = {"unilib_ingredient_cone_spruce.png"},
        groups = group_table,
        sounds = unilib.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_cone_spruce.png^[transformR180",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 0.8,
        walkable = false,
        wield_image = "unilib_ingredient_cone_spruce.png^[transformR180",
    })

end


function unilib.pkg.ingredient_cone_spruce.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:ingredient_cone_spruce",

        replace_mode = mode,
        leaves_list = {"unilib:tree_spruce_leaves"},
        pkg_list = {"tree_spruce"},
    })

end
