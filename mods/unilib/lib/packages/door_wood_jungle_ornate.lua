---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_jungle_ornate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_jungle_ornate.init()

    return {
        description = "Ornate jungle tree wood door",
        depends = "tree_jungle",
    }

end

function unilib.pkg.door_wood_jungle_ornate.exec()

    unilib.register_door({
        -- From moretrapdoors:jungle_door. Creates unilib:door_wood_jungle_ornate
        part_name = "wood_jungle_ornate",
        orig_name = {
            "doors:jungle_door_a",
            "doors:jungle_door_b",
            "doors:jungle_door_c",
            "doors:jungle_door_d",
        },
        def_table = {
            description = S("Ornate Jungle Tree Wood Door"),
            tiles = {{name = "unilib_door_wood_jungle_ornate.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_jungle_ornate_inv.png",
            recipe = {
                {"unilib:tree_jungle_wood", "unilib:tree_jungle_wood"},
                {"unilib:tree_jungle_trunk", "unilib:tree_jungle_trunk"},
                {"unilib:tree_jungle_wood", "unilib:tree_jungle_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:jungle_door",
    })

end
