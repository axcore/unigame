---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_glass_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.doors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_glass_ordinary.init()

    return {
        description = "Ordinary glass door",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.door_glass_ordinary.exec()

    unilib.register_door({
        -- From doors:door_glass. Creates unilib:door_glass_ordinary_closed_left, etc
        part_name = "glass_ordinary",
        orig_name_list = {
            "doors:door_glass_a",
            "doors:door_glass_b",
            "doors:door_glass_c",
            "doors:door_glass_d",
        },
        def_table = {
            description = S("Ordinary glass Door"),
            tiles = {"unilib_door_glass.png"},
            groups = {cracky = 3, node = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            gain_close = 0.25,
            gain_open = 0.3,
            inventory_image = "unilib_door_glass_inv.png",
            recipe = {
                {"unilib:glass_ordinary", "unilib:glass_ordinary"},
                {"unilib:glass_ordinary", "unilib:glass_ordinary"},
                {"unilib:glass_ordinary", "unilib:glass_ordinary"},
            },
            sound_close = "unilib_glass_door_close",
            sound_open = "unilib_glass_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_glass",
    })

end
