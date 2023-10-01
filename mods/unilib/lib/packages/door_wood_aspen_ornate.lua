---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_aspen_ornate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_aspen_ornate.init()

    return {
        description = "Ornate aspen wood door",
        depends = "tree_aspen",
    }

end

function unilib.pkg.door_wood_aspen_ornate.exec()

    unilib.register_door({
        -- From moretrapdoors:aspen_doors. Creates unilib:door_wood_aspen_ornate
        part_name = "wood_aspen_ornate",
        orig_name = {
            "doors:aspen_doors_a",
            "doors:aspen_doors_b",
            "doors:aspen_doors_c",
            "doors:aspen_doors_d",
        },
        def_table = {
            description = S("Ornate Aspen Wood Door"),
            tiles = {{name = "unilib_door_wood_aspen_ornate.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_aspen_ornate_inv.png",
            recipe = {
                {"unilib:tree_aspen_wood", "unilib:tree_aspen_wood"},
                {"unilib:tree_aspen_trunk", "unilib:tree_aspen_trunk"},
                {"unilib:tree_aspen_wood", "unilib:tree_aspen_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:aspen_doors",
    })

end
