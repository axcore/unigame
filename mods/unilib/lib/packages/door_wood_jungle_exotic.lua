---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_jungle_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_jungle_exotic.init()

    return {
        description = "Exotic jungle tree wood door",
        depends = "tree_jungle_exotic",
    }

end

function unilib.pkg.door_wood_jungle_exotic.exec()

    local burnlevel = 5

    unilib.register_door({
        -- From farlands, doors:door_jungle_wood. Creates
        --      unilib:door_wood_jungle_exotic_closed_left, etc
        part_name = "wood_jungle_exotic",
        orig_name_list = {nil, nil, nil, nil},
        def_table = {
            description = S("Exotic Jungle Tree Wood Door"),
            tiles = {{name = "unilib_door_wood_jungle_exotic.png", backface_culling = true}},
            -- N.B. switched door = 1 to node = 1 for consistency with other packages
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_jungle_exotic_inv.png",
            recipe = {
                {"unilib:tree_jungle_exotic_wood", "unilib:tree_jungle_exotic_wood"},
                {"unilib:tree_jungle_exotic_wood", "unilib:tree_jungle_exotic_wood"},
                {"unilib:tree_jungle_exotic_wood", "unilib:tree_jungle_exotic_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = nil,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:door_wood_jungle_exotic",
        burntime = unilib.global.tree_burn_table.door[burnlevel]
    })

end
