---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:" .. id .. "_ore", {
    description = name .. " Ore",
    tiles = {"default_stone.png^underch_" .. id .."_ore.png"},
    groups = {cracky=2},
    drop = item,
    sounds = default.node_sound_stone_defaults(),
})

underch.gems.register_gem("Emerald", "emerald");
]]--
