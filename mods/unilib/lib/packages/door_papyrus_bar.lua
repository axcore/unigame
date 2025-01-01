---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_papyrus_bar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_papyrus_bar.init()

    return {
        description = "Papyrus bar door",
        depends = {"item_string_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.door_papyrus_bar.exec()

    unilib.register_door({
        -- From mtg_plus mod, doors:door_papyrus. Creates unilib:door_papyrus_bar_closed_left, etc
        part_name = "papyrus_bar",
        orig_name_list = {
            "doors:door_papyrus_bar_a",
            "doors:door_papyrus_bar_b",
            "doors:door_papyrus_bar_c",
            "doors:door_papyrus_bar_d",
        },
        def_table = {
            description = S("Papyrus Bar Door"),
            tiles = {{name = "unilib_door_papyrus_bar.png", backface_culling = true}},
            groups = {choppy = 1, flammable = 2, snappy = 2},
            sounds = unilib.global.sound_table.leaves,

            inventory_image = "unilib_door_papyrus_bar_inv.png",
            recipe = {
                {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
                {"unilib:item_string_ordinary", "unilib:item_string_ordinary"},
                {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
            },
            sound_close = "unilib_gate_close",
            sound_open = "unilib_gate_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_papyrus",
    })
    unilib.register_craft({
        -- From mtg_plus mod, doors:door_papyrus
        type = "fuel",
        recipe = "unilib:door_papyrus_bar",
        burntime = 4,
    })

end
