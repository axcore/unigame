---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local corals = {
    "Orange",
}

for k,v in pairs(corals) do
    minetest.register_node("decorations_sea:coral_0" .. k, {
        description = v .. " Coral",
        tiles = {"decorations_sea_coral_node_0" .. k .. ".png"},
        groups = {cracky = 3},
        drop = "default:coral_skeleton",
        sounds = default.node_sound_stone_defaults(),
    })
end
]]--
