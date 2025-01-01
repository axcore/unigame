---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/oak
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_oak_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.oak.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_oak_mature.init()

    return {
        description = "Mature oak wood door",
        depends = "tree_oak_mature",
    }

end

function unilib.pkg.door_wood_oak_mature.exec()

    unilib.register_door({
        -- From cool_trees/oak, doors:door_oak_wood. Creates
        --      unilib:door_wood_oak_mature_closed_left, etc
        part_name = "wood_oak_mature",
        orig_name_list = {
            "doors:door_oak_wood_a",
            "doors:door_oak_wood_b",
            "doors:door_oak_wood_c",
            "doors:door_oak_wood_d",
        },
        def_table = {
            description = S("Mature Oak Wood Door"),
            tiles = {{name = "unilib_door_wood_oak_mature.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_oak_mature_inv.png",
            recipe = {
                {"unilib:tree_oak_mature_wood", "unilib:tree_oak_mature_wood"},
                {"unilib:tree_oak_mature_wood", "unilib:tree_oak_mature_wood"},
                {"unilib:tree_oak_mature_wood", "unilib:tree_oak_mature_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_oak_wood",
    })
    -- (no fuel recipe)

end
