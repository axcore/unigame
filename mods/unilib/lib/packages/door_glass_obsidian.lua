---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_glass_obsidian = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.doors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_glass_obsidian.init()

    return {
        description = "Obsidian glass door",
        depends = "glass_obsidian",
    }

end

function unilib.pkg.door_glass_obsidian.exec()

    unilib.register_door({
        -- From doors:door_obsidian_glass. Creates unilib:door_glass_obsidian
        part_name = "glass_obsidian",
        orig_name = {
            "doors:door_obsidian_glass_a",
            "doors:door_obsidian_glass_b",
            "doors:door_obsidian_glass_c",
            "doors:door_obsidian_glass_d",
        },
        def_table = {
            description = S("Obsidian Glass Door"),
            tiles = {"unilib_door_glass_obsidian.png"},
            groups = {cracky = 3, node = 1},
            sounds = unilib.sound_table.glass,

            gain_close = 0.25,
            gain_open = 0.3,
            inventory_image = "unilib_door_glass_obsidian_inv.png",
            recipe = {
                {"unilib:glass_obsidian", "unilib:glass_obsidian"},
                {"unilib:glass_obsidian", "unilib:glass_obsidian"},
                {"unilib:glass_obsidian", "unilib:glass_obsidian"},
            },
            sound_close = "unilib_glass_door_close",
            sound_open = "unilib_glass_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_obsidian_glass",
    })

end
