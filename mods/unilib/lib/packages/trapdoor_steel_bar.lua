---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_steel_bar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xpanes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_steel_bar.init()

    return {
        description = "Steel bar trapdoor",
        depends = "pane_steel_bar",
    }

end

function unilib.pkg.trapdoor_steel_bar.exec()

    unilib.register_trapdoor({
        -- From xpanes:trapdoor_steel_bar. Creates unilib:trapdoor_steel_bar_closed, etc
        part_name = "steel_bar",
        orig_name_list = {"xpanes:trapdoor_steel_bar", "xpanes:trapdoor_steel_bar_open"},
        def_table = {
            description = S("Steel Bar Trapdoor"),
            -- (no tiles)
            groups = {cracky = 1, door = 1, level = 2, node = 1},
            sounds = unilib.global.sound_table.metal,

            gain_close = 0.13,
            gain_open = 0.15,
            inventory_image = "unilib_trapdoor_steel_bar.png",
            protected_flag = true,
            sound_close = "unilib_steel_bar_door_close",
            sound_open = "unilib_steel_bar_door_open",
            tile_front = "unilib_trapdoor_steel_bar.png",
            tile_side = "unilib_trapdoor_steel_bar_side.png",
            wield_image = "unilib_trapdoor_steel_bar.png",
        },

        replace_mode = mode,
    })
    unilib.register_craft_2x2({
        -- From doors:trapdoor_steel
        output = "unilib:trapdoor_steel_bar",
        ingredient = "unilib:pane_steel_bar_flat",
    })

end
