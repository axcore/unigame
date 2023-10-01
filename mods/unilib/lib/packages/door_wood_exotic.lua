---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_exotic.init()

    return {
        description = "Exotic tree wood door",
        depends = "tree_exotic",
    }

end

function unilib.pkg.door_wood_exotic.exec()

    local burnlevel = 3

    unilib.register_door({
        -- From farlands, doors:door_wood. Creates unilib:door_wood_exotic
        part_name = "wood_exotic",
        orig_name = {nil, nil, nil, nil},
        def_table = {
            description = S("Exotic Tree Wood Door"),
            tiles = {{name = "unilib_door_wood_exotic.png", backface_culling = true}},
            -- N.B. switched door = 1 to node = 1 for consistency with other packages
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_exotic_inv.png",
            recipe = {
                {"unilib:tree_exotic_wood", "unilib:tree_exotic_wood"},
                {"unilib:tree_exotic_wood", "unilib:tree_exotic_wood"},
                {"unilib:tree_exotic_wood", "unilib:tree_exotic_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = nil,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:door_wood_exotic",
        burntime = unilib.tree_burn_table.door[burnlevel]
    })

end
