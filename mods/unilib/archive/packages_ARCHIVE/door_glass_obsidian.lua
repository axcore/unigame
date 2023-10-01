---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register("door_obsidian_glass", {
    tiles = {"doors_door_obsidian_glass.png"},
    description = S("Obsidian Glass Door"),
    inventory_image = "doors_item_obsidian_glass.png",
    groups = {node = 1, cracky=3},
    sounds = default.node_sound_glass_defaults(),
    sound_open = "doors_glass_door_open",
    sound_close = "doors_glass_door_close",
    gain_open = 0.3,
    gain_close = 0.25,
    recipe = {
        {"default:obsidian_glass", "default:obsidian_glass"},
        {"default:obsidian_glass", "default:obsidian_glass"},
        {"default:obsidian_glass", "default:obsidian_glass"},
    },
})
]]--
