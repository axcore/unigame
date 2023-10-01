---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_aspen_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_aspen_exotic.init()

    return {
        description = "Exotic aspen wood door",
        depends = "tree_aspen_exotic",
    }

end

function unilib.pkg.door_wood_aspen_exotic.exec()

    local burnlevel = 1

    unilib.register_door({
        -- From farlands, doors:door_aspen_wood. Creates unilib:door_wood_aspen_exotic
        part_name = "wood_aspen_exotic",
        orig_name = {nil, nil, nil, nil},
        def_table = {
            description = S("Exotic Aspen Wood Door"),
            tiles = {{name = "unilib_door_wood_aspen_exotic.png", backface_culling = true}},
            -- N.B. switched door = 1 to node = 1 for consistency with other packages
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_aspen_exotic_inv.png",
            recipe = {
                {"unilib:tree_aspen_exotic_wood", "unilib:tree_aspen_exotic_wood"},
                {"unilib:tree_aspen_exotic_wood", "unilib:tree_aspen_exotic_wood"},
                {"unilib:tree_aspen_exotic_wood", "unilib:tree_aspen_exotic_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = nil,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:door_wood_aspen_exotic",
        burntime = unilib.tree_burn_table.door[burnlevel]
    })

end
