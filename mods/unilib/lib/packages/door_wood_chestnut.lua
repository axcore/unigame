---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_chestnut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.chestnuttree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_chestnut.init()

    return {
        description = "Chestnut wood door",
        depends = "tree_chestnut",
    }

end

function unilib.pkg.door_wood_chestnut.exec()

    unilib.register_door({
        -- From cool_trees/chestnuttree, doors:door_chestnut_wood. Creates unilib:door_wood_chestnut
        part_name = "wood_chestnut",
        orig_name = {
            "doors:door_chestnut_wood_a",
            "doors:door_chestnut_wood_b",
            "doors:door_chestnut_wood_c",
            "doors:door_chestnut_wood_d",
        },
        def_table = {
            description = S("Chestnut Wood Door"),
            tiles = {{name = "unilib_door_wood_chestnut.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_chestnut_inv.png",
            recipe = {
                {"unilib:tree_chestnut_wood", "unilib:tree_chestnut_wood"},
                {"unilib:tree_chestnut_wood", "unilib:tree_chestnut_wood"},
                {"unilib:tree_chestnut_wood", "unilib:tree_chestnut_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_chestnut_wood",
    })
    -- (no fuel recipe)

end
