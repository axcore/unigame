---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_steel_rusty_prison = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_steel_rusty_prison.init()

    return {
        description = "Rusty steel prison door",
        depends = "pane_bars_iron_rusty",
    }

end

function unilib.pkg.door_steel_rusty_prison.exec()

    unilib.register_door({
        -- From xdecor, doors:rusty_prison_door. Creates unilib:door_steel_rusty_prison
        part_name = "steel_rusty_prison",
        orig_name = {
            "doors:rusty_prison_door_a",
            "doors:rusty_prison_door_b",
            "doors:rusty_prison_door_c",
            "doors:rusty_prison_door_d",
        },
        def_table = {
            description = S("Rusty Steel Prison Door"),
            tiles = {{name = "unilib_door_steel_rusty_prison.png", backface_culling = true}},
            groups = {choppy = 2, cracky = 2, door = 1, oddly_breakable_by_hand = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.metal,

            inventory_image = "unilib_door_steel_rusty_prison_inv.png",
            protected_flag = true,
            -- N.B. Original craft recipe conflicts with recipe in "door_steel_bar" package
            --[[
            recipe = {
                {"unilib:pane_bars_iron_rusty_flat", "unilib:pane_bars_iron_rusty_flat"},
                {"unilib:pane_bars_iron_rusty_flat", "unilib:pane_bars_iron_rusty_flat"},
                {"unilib:pane_bars_iron_rusty_flat", "unilib:pane_bars_iron_rusty_flat"},
            },
            ]]--
            recipe = {
                {"unilib:pane_bars_iron_rusty_flat", "", "unilib:pane_bars_iron_rusty_flat"},
                {"unilib:pane_bars_iron_rusty_flat", "", "unilib:pane_bars_iron_rusty_flat"},
                {"unilib:pane_bars_iron_rusty_flat", "", "unilib:pane_bars_iron_rusty_flat"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:rusty_prison_door",
    })

end
