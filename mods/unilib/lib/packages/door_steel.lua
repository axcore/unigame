---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.doors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_steel.init()

    return {
        description = "Steel door",
        depends = "metal_steel",
    }

end

function unilib.pkg.door_steel.exec()

    unilib.register_door({
        -- From doors:door_steel. Creates unilib:door_steel_closed_left, etc
        part_name = "steel",
        orig_name_list = {
            "doors:door_steel_a",
            "doors:door_steel_b",
            "doors:door_steel_c",
            "doors:door_steel_d",
        },
        def_table = {
            description = S("Steel Door"),
            tiles = {{ name = "unilib_door_steel.png", backface_culling = true }},
            groups = {cracky = 1, level = 2, node = 1},
            sounds = unilib.global.sound_table.metal,

            gain_close = 0.2,
            gain_open = 0.2,
            inventory_image = "unilib_door_steel_inv.png",
            protected_flag = true,
            recipe = {
                {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
                {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
                {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            },
            sound_close = "unilib_steel_door_close",
            sound_open = "unilib_steel_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_steel",
    })

end
