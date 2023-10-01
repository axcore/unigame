---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_apple_ornate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_apple_ornate.init()

    return {
        description = "Ornate apple tree wood door",
        depends = "tree_apple",
    }

end

function unilib.pkg.door_wood_apple_ornate.exec()

    unilib.register_door({
        -- From moretrapdoors:wooden_doors. Creates unilib:door_wood_apple_ornate
        part_name = "wood_apple_ornate",
        orig_name = {
            "doors:wooden_doors_a",
            "doors:wooden_doors_b",
            "doors:wooden_doors_c",
            "doors:wooden_doors_d",
        },
        def_table = {
            description = S("Ornate Apple Tree Wood Door"),
            tiles = {{name = "unilib_door_wood_apple_ornate.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_apple_ornate_inv.png",
            recipe = {
                {"unilib:tree_apple_wood", "unilib:tree_apple_wood"},
                {"unilib:tree_apple_trunk", "unilib:tree_apple_trunk"},
                {"unilib:tree_apple_wood", "unilib:tree_apple_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:wooden_doors",
    })

end
