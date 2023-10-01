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
local add_moss = function(typ, descr, texture, receipe_item)

	minetest.register_node("ethereal:" .. typ .. "_moss", {
		description = S(descr .. " Moss"),
		tiles = {texture},
		groups = {crumbly = 3},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = 0.4}})
	})

	minetest.register_craft({
		type = "shapeless",
		output = "ethereal:" .. typ .. "_moss",
		recipe = {"default:dirt", receipe_item}
	})
end

add_moss( "green", "Green", "default_grass.png", "default:jungleleaves")
]]--
