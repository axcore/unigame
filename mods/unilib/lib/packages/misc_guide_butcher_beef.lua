---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_guide_butcher_beef = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_guide_butcher_beef.init()

    return {
        description = "Butcher's guide to beef",
    }

end

function unilib.pkg.misc_guide_butcher_beef.exec()

    unilib.register_node("unilib:misc_guide_butcher_beef", "bbq:beef_map", mode, {
        -- From bbq:beef_map
        description = S("Butcher's Guide to Beef"),
        tiles = {
            "unilib_tree_jungle_wood.png",
            "unilib_tree_jungle_wood.png",
            "unilib_tree_jungle_wood.png",
            "unilib_tree_jungle_wood.png",
            "unilib_tree_jungle_wood.png",
            "unilib_misc_guide_butcher_beef.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_guide_butcher_beef.png",
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
        -- From bbq:beef_map
        output = "unilib:misc_guide_butcher_beef",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "group:leather", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        }
    })
    unilib.register_external_ingredient("unilib:misc_guide_butcher_beef", {
        "group:leather",                        -- Originally mobs:leather
    })

end
