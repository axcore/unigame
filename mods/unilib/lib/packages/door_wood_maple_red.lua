---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/maple
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_maple_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maple.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_maple_red.init()

    return {
        description = "Red maple wood door",
        depends = "tree_maple_red",
    }

end

function unilib.pkg.door_wood_maple_red.exec()

    unilib.register_door({
        -- From cool_trees/maple, doors:door_maple_wood. Creates unilib:door_wood_maple_red
        part_name = "wood_maple",
        orig_name = {
            "doors:door_maple_wood_a",
            "doors:door_maple_wood_b",
            "doors:door_maple_wood_c",
            "doors:door_maple_wood_d",
        },
        def_table = {
            description = S("Red Maple Wood Door"),
            tiles = {{name = "unilib_door_wood_maple_red.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_maple_red_inv.png",
            recipe = {
                {"unilib:tree_maple_red_wood", "unilib:tree_maple_red_wood"},
                {"unilib:tree_maple_red_wood", "unilib:tree_maple_red_wood"},
                {"unilib:tree_maple_red_wood", "unilib:tree_maple_red_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_maple_wood",
    })
    -- (no fuel recipe)

end
