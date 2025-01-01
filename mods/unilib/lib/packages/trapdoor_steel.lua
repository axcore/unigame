---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.doors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_steel.init()

    return {
        description = "Steel trapdoor",
        depends = "metal_steel",
    }

end

function unilib.pkg.trapdoor_steel.exec()

    unilib.register_trapdoor({
        -- From doors:trapdoor_steel. Creates unilib:trapdoor_steel_closed, etc
        part_name = "steel",
        orig_name_list = {"doors:trapdoor_steel", "doors:trapdoor_steel_open"},
        def_table = {
            description = S("Steel Trapdoor"),
            -- (no tiles)
            groups = {cracky = 1, door = 1, level = 2},
            sounds = unilib.global.sound_table.metal,

            gain_close = 0.2,
            gain_open = 0.2,
            inventory_image = "unilib_trapdoor_steel.png",
            protected_flag = true,
            sound_close = "unilib_steel_door_close",
            sound_open = "unilib_steel_door_open",
            tile_front = "unilib_trapdoor_steel.png",
            tile_side = "unilib_trapdoor_steel_side.png",
            wield_image = "unilib_trapdoor_steel.png",
        },

        replace_mode = mode,
    })
    -- From doors:trapdoor_steel
    unilib.register_craft_2x2({
        output = "unilib:trapdoor_steel",
        ingredient = "unilib:metal_steel_ingot",
    })

end
