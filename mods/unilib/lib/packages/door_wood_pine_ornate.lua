---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_pine_ornate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_pine_ornate.init()

    return {
        description = "Ornate pine wood door",
        depends = "tree_pine",
    }

end

function unilib.pkg.door_wood_pine_ornate.exec()

    unilib.register_door({
        -- From moretrapdoors:pine_door. Creates unilib:door_wood_pine_ornate
        part_name = "wood_pine_ornate",
        orig_name = {
            "doors:pine_door_a",
            "doors:pine_door_b",
            "doors:pine_door_c",
            "doors:pine_door_d",
        },
        def_table = {
            description = S("Ornate Pine Wood Door"),
            tiles = {{name = "unilib_door_wood_pine_ornate.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_pine_ornate_inv.png",
            recipe = {
                {"unilib:tree_pine_wood", "unilib:tree_pine_wood"},
                {"unilib:tree_pine_trunk", "unilib:tree_pine_trunk"},
                {"unilib:tree_pine_wood", "unilib:tree_pine_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:pine_door",
    })

end
