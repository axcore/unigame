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
doors.register("door_glass", {
    tiles = {"doors_door_glass.png"},
    description = S("Glass Door"),
    inventory_image = "doors_item_glass.png",
    groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
    sounds = default.node_sound_glass_defaults(),
    sound_open = "doors_glass_door_open",
    sound_close = "doors_glass_door_close",
    gain_open = 0.3,
    gain_close = 0.25,
    recipe = {
        {"default:glass", "default:glass"},
        {"default:glass", "default:glass"},
        {"default:glass", "default:glass"},
    }
})
]]--
