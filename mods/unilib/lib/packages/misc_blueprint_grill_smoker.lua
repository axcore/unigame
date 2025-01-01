---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_blueprint_grill_smoker = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_blueprint_grill_smoker.init()

    return {
        description = "Smoker grill blueprint",
        depends = "dye_basic",
    }

end

function unilib.pkg.misc_blueprint_grill_smoker.exec()

    unilib.register_node("unilib:misc_blueprint_grill_smoker", "bbq:smoker_blueprint", mode, {
        -- From bbq:smoker_blueprint
        description = S("Smoker Grill Blueprint"),
        tiles = {
            "unilib_tree_pine_wood.png",
            "unilib_tree_pine_wood.png",
            "unilib_tree_pine_wood.png",
            "unilib_tree_pine_wood.png",
            "unilib_tree_pine_wood.png",
            "unilib_misc_blueprint_grill_smoker.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_blueprint_grill_smoker.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5},
            },
        },
        paramtype2 = "facedir",
        paramtype = "light",
    })
    unilib.register_craft({
        -- From bbq:smoker_blueprint
        output = "unilib:misc_blueprint_grill_smoker",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:dye_blue", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

end
