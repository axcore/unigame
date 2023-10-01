---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_steel_dungeon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_steel_dungeon.init()

    return {
        description = "Steel dungeon door",
        depends = "pane_steel_dungeon",
    }

end

function unilib.pkg.door_steel_dungeon.exec()

    unilib.register_door({
        -- From castle_gates:jail_door. Creates unilib:door_steel_dungeon
        part_name = "steel_dungeon",
        orig_name = {
            "castle_gates:jail_door_a",
            "castle_gates:jail_door_b",
            "castle_gates:jail_door_c",
            "castle_gates:jail_door_d",
        },
        def_table = {
            description = S("Steel Dungeon Door"),
            tiles = {{name = "unilib_door_steel_dungeon.png", backface_culling = true}},
            groups = {cracky = 2, door = 1, flow_through = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.metal,

            inventory_image = "unilib_door_steel_dungeon_inv.png",
            protected_flag = true,
            recipe = {
                {"unilib:pane_steel_dungeon_flat", "unilib:pane_steel_dungeon_flat"},
                {"unilib:pane_steel_dungeon_flat", "unilib:pane_steel_dungeon_flat"},
                {"unilib:pane_steel_dungeon_flat", "unilib:pane_steel_dungeon_flat"},
            },
            sound_close = "unilib_steel_bar_door_close",
            sound_open = "unilib_steel_bar_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "castle_gates:oak_door",
    })

end
