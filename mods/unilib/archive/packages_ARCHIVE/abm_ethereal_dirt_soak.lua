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
-- If Water Source near Dry Dirt, change to normal Dirt
minetest.register_abm({
	label = "Ethereal wet dry dirt",
	nodenames = {
		"ethereal:dry_dirt", "default:dirt_with_dry_grass",
		"default:dry_dirt", "default:dry_dirt_with_dry_grass"
	},
	neighbors = {"group:water"},
	interval = 15,
	chance = 2,
	catch_up = false,
	action = function(pos, node)

		if node.name == "ethereal:dry_dirt"
		or node.name == "default:dry_dirt" then
			minetest.swap_node(pos, {name = "default:dirt"})
		else
			minetest.swap_node(pos, {name = "default:dirt_with_dry_grass"})
		end
	end,
})
]]--
