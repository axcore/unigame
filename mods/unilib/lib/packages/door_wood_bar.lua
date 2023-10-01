---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_bar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_bar.init()

    return {
        description = "Wooden bar door",
        depends = "pane_bars_wooden",
    }

end

function unilib.pkg.door_wood_bar.exec()

    unilib.register_door({
        -- From mtg_plus mod, doors:door_wood_bar. Creates unilib:door_wood_bar
        part_name = "wood_bar",
        orig_name = {
            "doors:door_wood_bar_a",
            "doors:door_wood_bar_b",
            "doors:door_wood_bar_c",
            "doors:door_wood_bar_d",
        },
        def_table = {
            description = S("Wooden Bar Door"),
            tiles = {{name = "unilib_door_wood_bar.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 2},
            sounds = unilib.sound_table.wood,

            inventory_image = "unilib_door_wood_bar_inv.png",
            recipe = {
                {"unilib:pane_bars_wooden_flat"},
                {"unilib:pane_bars_wooden_flat"},
            },
            sound_close = "unilib_gate_close",
            sound_open = "unilib_gate_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_wood_bar",
    })
    unilib.register_craft({
        -- From mtg_plus mod, doors:door_wood_bar
        type = "fuel",
        recipe = "unilib:door_wood_bar",
        burntime = 4,
    })

end
