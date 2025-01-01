---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/larch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_larch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.larch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_larch.init()

    return {
        description = "Larch wood door",
        depends = "tree_larch",
    }

end

function unilib.pkg.door_wood_larch.exec()

    unilib.register_door({
        -- From cool_trees/larch, doors:door_larch_wood. Creates unilib:door_wood_larch_closed_left,
        --      etc
        part_name = "wood_larch",
        orig_name_list = {
            "doors:door_larch_wood_a",
            "doors:door_larch_wood_b",
            "doors:door_larch_wood_c",
            "doors:door_larch_wood_d",
        },
        def_table = {
            description = S("Larch Wood Door"),
            tiles = {{name = "unilib_door_wood_larch.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_larch_inv.png",
            recipe = {
                {"unilib:tree_larch_wood", "unilib:tree_larch_wood"},
                {"unilib:tree_larch_wood", "unilib:tree_larch_wood"},
                {"unilib:tree_larch_wood", "unilib:tree_larch_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_larch_wood",
    })
    -- (no fuel recipe)

end
