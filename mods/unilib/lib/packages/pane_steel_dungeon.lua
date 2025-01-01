---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_steel_dungeon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_steel_dungeon.init()

    return {
        description = "Steel dungeon bars",
        depends = "metal_steel",
    }

end

function unilib.pkg.pane_steel_dungeon.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_pane({
        -- From castle_gates, xpanes:jailbars_flat. Creates unilib:pane_steel_dungeon_flat,
        --      unilib:pane_steel_dungeon_crossed
        -- N.B. tiles = {"castle_jailbars.png"} omitted from original code
        part_name = "steel_dungeon",
        orig_name = {"xpanes:jailbars", "xpanes:jailbars_flat"},
        def_table = {
            description = S("Steel Dungeon Bars"),
            textures = {
                "unilib_pane_steel_dungeon.png",
                "unilib_pane_steel_dungeon.png",
                "unilib_door_steel_castle.png",
            },
            -- N.B. pane = 1 omitted from original code
            groups = {cracky = 1, flow_through = 1},
            sounds = unilib.global.sound_table.metal,

            inventory_image = "unilib_pane_steel_dungeon.png",
            -- N.B. drawtype, paramtype omitted from original code
--          drawtype = "airlike",
--          paramtype = "light",
            recipe = {
                {c_ingot, c_ingot, c_ingot},
                {c_ingot, "", c_ingot},
                {c_ingot, c_ingot, c_ingot},
            },
            wield_image = "unilib_pane_steel_dungeon.png",
        },

        replace_mode = mode,
    })

end
