---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_steel_bar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xpanes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_steel_bar.init()

    return {
        description = "Steel bar door",
        depends = "pane_steel_bar",
    }

end

function unilib.pkg.door_steel_bar.exec()

    unilib.register_door({
        -- From xpanes:door_steel_bar. Creates unilib:door_steel_bar_closed_left, etc
        part_name = "steel_bar",
        orig_name_list = {
            "xpanes:door_steel_bar_a",
            "xpanes:door_steel_bar_b",
            "xpanes:door_steel_bar_c",
            "xpanes:door_steel_bar_d",
        },
        def_table = {
            description = S("Steel Bar Door"),
            tiles = {{name = "unilib_door_steel_bar.png", backface_culling = true}},
            groups = {cracky = 1, level = 2, node = 1},
            sounds = unilib.global.sound_table.metal,

            gain_close = 0.13,
            gain_open = 0.15,
            inventory_image = "unilib_door_steel_bar_inv.png",
            protected_flag = true,
            recipe = {
                {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
                {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
                {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
            },
            sound_close = "unilib_steel_bar_door_close",
            sound_open = "unilib_steel_bar_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "xpanes:door_steel_bar",
    })

end
