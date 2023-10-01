---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/birch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_birch_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.birch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_birch_mature.init()

    return {
        description = "Mature birch wood door",
        depends = "tree_birch_mature",
    }

end

function unilib.pkg.door_wood_birch_mature.exec()

    unilib.register_door({
        -- From cool_trees/birch, doors:door_birch_wood. Creates unilib:door_wood_birch_mature
        part_name = "wood_birch_mature",
        orig_name = {
            "doors:door_birch_wood_a",
            "doors:door_birch_wood_b",
            "doors:door_birch_wood_c",
            "doors:door_birch_wood_d",
        },
        def_table = {
            description = S("Mature Birch Wood Door"),
            tiles = {{name = "unilib_door_wood_birch_mature.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_birch_mature_inv.png",
            recipe = {
                {"unilib:tree_birch_mature_wood", "unilib:tree_birch_mature_wood"},
                {"unilib:tree_birch_mature_wood", "unilib:tree_birch_mature_wood"},
                {"unilib:tree_birch_mature_wood", "unilib:tree_birch_mature_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_birch_wood",
    })
    -- (no fuel recipe)

end
