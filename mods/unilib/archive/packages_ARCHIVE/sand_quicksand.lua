---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:quicksand2", {
	description = S("Quicksand"),
	tiles = {"default_sand.png^[colorize:#00004F10"},
	drawtype = "glasslike",
	paramtype = "light",
	drop = "default:sand",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "ethereal:quicksand2",
	liquid_alternative_source = "ethereal:quicksand2",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 1,
	walkable = false,
	climbable = false,
	post_effect_color = {r = 230, g = 210, b = 160, a = 245},
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})
minetest.register_craft({
	output = "ethereal:quicksand2",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "bucket:bucket_water", "group:sand"},
		{"group:sand", "group:sand", "group:sand"}
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"}
	}
})
]]--
