---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_steel_icy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_steel_icy.init()

    return {
        description = "Icy steel trapdoor",
        depends = {"trapdoor_ice", "trapdoor_steel"},
    }

end

function unilib.pkg.trapdoor_steel_icy.exec()

    unilib.register_trapdoor({
        -- From mtg_plus:trapdoor_icesteel. Creates unilib:trapdoor_steel_icy
        part_name = "steel_icy",
        orig_name = {"mtg_plus:trapdoor_icesteel", "mtg_plus:trapdoor_icesteel_open"},
        def_table = {
            description = S("Icy Steel Trapdoor"),
            -- (no tiles)
            groups = {
                bendy = 2, cracky = 3, door = 1, level = 2, melty = 3, slippery = 1, snappy = 1,
            },
            sounds = unilib.sound_table.metal,

            inventory_image = "unilib_trapdoor_steel_icy.png",
            protected_flag = true,
            sound_close = "unilib_icy_steel_door_close",
            sound_open = "unilib_icy_steel_door_open",
            tile_front = "unilib_trapdoor_steel_icy.png",
            tile_side = "unilib_trapdoor_steel_icy_side.png",
            wield_image = "unilib_trapdoor_steel_icy.png",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From mtg_plus:trapdoor_icesteel
        type = "shapeless",
        output = "unilib:trapdoor_steel_icy 2",
        recipe = {"unilib:trapdoor_ice", "unilib:trapdoor_steel"},
    })

end
