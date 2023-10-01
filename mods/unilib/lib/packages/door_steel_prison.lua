---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_steel_prison = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_steel_prison.init()

    return {
        description = "Steel prison door",
        depends = "pane_steel_bar",
    }

end

function unilib.pkg.door_steel_prison.exec()

    unilib.register_door({
        -- From xdecor, doors:prison_door. Creates unilib:door_steel_prison
        part_name = "steel_prison",
        orig_name = {
            "doors:prison_door_a",
            "doors:prison_door_b",
            "doors:prison_door_c",
            "doors:prison_door_d",
        },
        def_table = {
            description = S("Steel Prison Door"),
            tiles = {{name = "unilib_door_steel_prison.png", backface_culling = true}},
            groups = {choppy = 2, cracky = 2, door = 1, oddly_breakable_by_hand = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.metal,


            inventory_image = "unilib_door_steel_prison_inv.png",
            protected_flag = true,
            -- N.B. Original craft recipe conflicts with recipe in "door_steel_bar" package
            --[[
            recipe = {
                {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
                {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
                {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
            },]]--
            recipe = {
                {"unilib:pane_steel_bar_flat", "", "unilib:pane_steel_bar_flat"},
                {"unilib:pane_steel_bar_flat", "", "unilib:pane_steel_bar_flat"},
                {"unilib:pane_steel_bar_flat", "", "unilib:pane_steel_bar_flat"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:prison_door",
    })

end
