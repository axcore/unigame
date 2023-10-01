---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node( "default:white_granite", {  
	description = "White Granite",
	tiles = { "default_granite_white.png" },
	is_ground_content = true,
	groups = {cracky=3, stone=1},
    sounds = {
		footstep = {name="default_stonestep"},
		dig = {name="default_stonetool"},
		place = {name="default_stoneplace"},
    },
})
]]--
