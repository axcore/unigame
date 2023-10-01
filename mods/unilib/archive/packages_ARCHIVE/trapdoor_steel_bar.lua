---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register_trapdoor("xpanes:trapdoor_steel_bar", {
    description = S("Steel Bar Trapdoor"),
    inventory_image = "xpanes_trapdoor_steel_bar.png",
    wield_image = "xpanes_trapdoor_steel_bar.png",
    tile_front = "xpanes_trapdoor_steel_bar.png",
    tile_side = "xpanes_trapdoor_steel_bar_side.png",
    protected = true,
    groups = {node = 1, cracky = 1, level = 2, door = 1},
    sounds = default.node_sound_metal_defaults(),
    sound_open = "xpanes_steel_bar_door_open",
    sound_close = "xpanes_steel_bar_door_close",
    gain_open = 0.15,
    gain_close = 0.13,
})
minetest.register_craft({
    output = "xpanes:trapdoor_steel_bar",
    recipe = {
        {"xpanes:bar_flat", "xpanes:bar_flat"},
        {"xpanes:bar_flat", "xpanes:bar_flat"},
    }
})
]]--
