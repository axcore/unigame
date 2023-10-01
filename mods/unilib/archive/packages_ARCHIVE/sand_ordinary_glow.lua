---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("valleys_c:glowing_sand", {
    description = "Sand with luminescent bacteria",
    tiles = {"default_sand.png"},
    groups = {crumbly = 3, falling_node = 1, sand = 1},
    light_source = 3,
    drop = "default:sand",
    sounds = default.node_sound_sand_defaults(),
})
]]--
