---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/clementinetree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_clementine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.clementinetree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_clementine.init()

    return {
        description = "Clementine tree wood door",
        depends = "tree_clementine",
    }

end

function unilib.pkg.door_wood_clementine.exec()

    unilib.register_door({
        -- From cool_trees/clementinetree, doors:door_clementinetree_wood. Creates
        --      unilib:door_wood_clementine
        part_name = "wood_clementine",
        orig_name = {
            "doors:door_clementinetree_wood_a",
            "doors:door_clementinetree_wood_b",
            "doors:door_clementinetree_wood_c",
            "doors:door_clementinetree_wood_d",
        },
        def_table = {
            description = S("Clementine Tree Wood Door"),
            tiles = {{name = "unilib_door_wood_clementine.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_clementine_inv.png",
            recipe = {
                {"unilib:tree_clementine_wood", "unilib:tree_clementine_wood"},
                {"unilib:tree_clementine_wood", "unilib:tree_clementine_wood"},
                {"unilib:tree_clementine_wood", "unilib:tree_clementine_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_clementinetree_wood",
    })
    -- (no fuel recipe)

end
