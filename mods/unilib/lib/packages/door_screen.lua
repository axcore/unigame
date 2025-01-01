---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_screen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_screen.init()

    return {
        description = "Screen door",
        depends = "pane_lattice_chainlink",
    }

end

function unilib.pkg.door_screen.exec()

    unilib.register_door({
        -- From xdecor, doors:screen_door. Creates unilib:door_screen_closed_left, etc
        part_name = "screen",
        orig_name_list = {
            "doors:screen_door_a",
            "doors:screen_door_b",
            "doors:screen_door_c",
            "doors:screen_door_d",
        },
        def_table = {
            description = S("Screen Door"),
            tiles = {{name = "unilib_door_screen.png", backface_culling = true}},
            -- N.B. node = 1 missing from original code
            groups = {choppy = 2, cracky = 2, door = 1, node = 1, oddly_breakable_by_hand = 1},
            -- (no sounds)

            inventory_image = "unilib_door_screen_inv.png",
            protected_flag = false,
            recipe = {
                {"group:wood", "group:wood"},
                {"unilib:pane_lattice_chainlink_flat", "unilib:pane_lattice_chainlink_flat"},
                {"group:wood", "group:wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:screen_door",
    })

end
