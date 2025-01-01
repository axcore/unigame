---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_steel_icy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_steel_icy.init()

    return {
        description = "Icy steel door",
        depends = {"door_ice", "door_steel"},
    }

end

function unilib.pkg.door_steel_icy.exec()

    unilib.register_door({
        -- From mtg_plus mod, doors:door_icesteel. Creates unilib:door_steel_icy_closed_left, etc
        part_name = "steel_icy",
        orig_name_list = {
            "doors:door_icesteel_a",
            "doors:door_icesteel_b",
            "doors:door_icesteel_c",
            "doors:door_icesteel_d",
        },
        def_table = {
            description = S("Icy Steel Door"),
            tiles = {{name = "unilib_door_steel_icy.png", backface_culling = true}},
            groups = {bendy = 2, cracky = 3, level = 2, melty = 3, slippery = 1, snappy = 1},
            sounds = unilib.global.sound_table.metal,

            inventory_image = "unilib_door_steel_icy_inv.png",
            protected_flag = true,
            sound_close = "unilib_icy_steel_door_close",
            sound_open = "unilib_icy_steel_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_wood_bar",
    })
    unilib.register_craft({
        -- From mtg_plus mod, doors:door_icesteel
        type = "shapeless",
        output = "unilib:door_steel_icy 2",
        recipe = {"unilib:door_ice", "unilib:door_steel"},
    })

end
