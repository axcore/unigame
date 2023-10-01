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
doors.register("door_steel", {
    tiles = {{name = "doors_door_steel.png", backface_culling = true}},
    description = S("Steel Door"),
    inventory_image = "doors_item_steel.png",
    protected = true,
    groups = {node = 1, cracky = 1, level = 2},
    sounds = default.node_sound_metal_defaults(),
    sound_open = "doors_steel_door_open",
    sound_close = "doors_steel_door_close",
    gain_open = 0.2,
    gain_close = 0.2,
    recipe = {
        {"default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot"},
    }
})
]]--
