---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_ipe_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_ipe_yellow.init()

    return {
        description = "Yellow Ipê wood door",
        depends = "tree_ipe_yellow",
    }

end

function unilib.pkg.door_wood_ipe_yellow.exec()

    unilib.register_door({
        -- From farlands, doors:door_yellow_ipewood. Creates
        --      unilib:door_wood_ipe_yellow_closed_left, etc
        part_name = "wood_ipe_yellow",
        orig_name_list = {nil, nil, nil, nil},
        def_table = {
            description = S("Yellow Ipê Wood Door"),
            tiles = {{name = "unilib_door_wood_ipe_yellow.png", backface_culling = true}},
            -- N.B. switched door = 1 to node = 1 for consistency with other packages
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wood_ipe_yellow_inv.png",
            recipe = {
                {"unilib:tree_ipe_yellow_wood", "unilib:tree_ipe_yellow_wood"},
                {"unilib:tree_ipe_yellow_wood", "unilib:tree_ipe_yellow_wood"},
                {"unilib:tree_ipe_yellow_wood", "unilib:tree_ipe_yellow_wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = nil,
    })

end
