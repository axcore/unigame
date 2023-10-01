---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/palm
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_palm = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.palm.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_palm.init()

    return {
        description = "Palm tree wood door",
        depends = "tree_palm",
    }

end

function unilib.pkg.door_wood_palm.exec()

    unilib.register_door({
        -- From cool_trees/palm, doors:door_palm_wood. Creates unilib:door_wood_palm
        part_name = "wood_palm",
        orig_name = {
            "doors:door_palm_wood_a",
            "doors:door_palm_wood_b",
            "doors:door_palm_wood_c",
            "doors:door_palm_wood_d",
        },
        def_table = {
            description = S("Palm Tree Wood Door"),
            tiles = {{name = "unilib_door_wood_palm.png", backface_culling = true}},
            -- N.B. node = 1 missing from original code for no obvious reason
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_palm_inv.png",
            recipe = {
                {"unilib:tree_palm_wood", "unilib:tree_palm_wood"},
                {"unilib:tree_palm_leaves", "unilib:tree_palm_leaves"},
                {"unilib:tree_palm_wood", "unilib:tree_palm_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_palm_wood",
    })
    -- (no fuel recipe)

end
