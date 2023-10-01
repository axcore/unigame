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
-- If Crystal Spike, Crystal Dirt, Snow near Water, change Water to Ice
minetest.register_abm({
	label = "Ethereal freeze water",
	nodenames = {
		"ethereal:crystal_spike", "default:snow", "default:snowblock",
		"ethereal:snowbrick"
	},
	neighbors = {"default:water_source", "default:river_water_source"},
	interval = 15,
	chance = 4,
	catch_up = false,
	action = function(pos, node)

		local near = minetest.find_node_near(pos, 1,
			{"default:water_source", "default:river_water_source"})

		if near then
			minetest.swap_node(near, {name = "default:ice"})
		end
	end,
})
]]--
