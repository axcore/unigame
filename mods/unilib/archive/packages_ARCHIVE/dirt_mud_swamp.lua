---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    30biomes
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("30biomes:mud", {
	description = "Mud",
	tiles = {"biomes_mud.png"},
	liquid_viscosity = 8,
	liquidtype = "source",
	liquid_renewable = false,
	liquid_alternative_source = "30biomes:mud",
	liquid_alternative_flowing = "30biomes:mud",
	liquid_range = 0,
	post_effect_color = {r=115, g=61, b=31, a=255},
	drowning = 1,
	walkable = false,
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
})
]]--
