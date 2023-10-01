---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_acacia_ornate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_acacia_ornate.init()

    return {
        description = "Ornate acacia wood door",
        depends = "tree_acacia",
    }

end

function unilib.pkg.door_wood_acacia_ornate.exec()

    unilib.register_door({
        -- From moretrapdoors:acacia_door. Creates unilib:door_wood_acacia_ornate
        part_name = "wood_acacia_ornate",
        orig_name = {
            "doors:acacia_door_a",
            "doors:acacia_door_b",
            "doors:acacia_door_c",
            "doors:acacia_door_d",
        },
        def_table = {
            description = S("Ornate Acacia Wood Door"),
            tiles = {{name = "unilib_door_wood_acacia_ornate.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_acacia_ornate_inv.png",
            recipe = {
                {"unilib:tree_acacia_wood", "unilib:tree_acacia_wood"},
                {"unilib:tree_acacia_trunk", "unilib:tree_acacia_trunk"},
                {"unilib:tree_acacia_wood", "unilib:tree_acacia_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:acacia_door",
    })

end
