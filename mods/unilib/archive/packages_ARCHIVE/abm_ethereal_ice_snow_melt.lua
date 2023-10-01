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
-- If Heat Source near Ice or Snow then melt.
minetest.register_abm({
	label = "Ethereal melt snow/ice",
	nodenames = {
		"default:ice", "default:snowblock", "default:snow",
		"default:dirt_with_snow", "ethereal:snowbrick", "ethereal:icebrick"
	},
	neighbors = {
		"fire:basic_fire", "default:lava_source", "default:lava_flowing",
		"default:furnace_active", "default:torch", "default:torch_wall",
		"default:torch_ceiling"
	},
	interval = 5,
	chance = 4,
	catch_up = false,
	action = function(pos, node)

		local water_node = "default:water"

		if pos.y > 2 then
			water_node = "default:river_water"
		end

		if node.name == "default:ice"
		or node.name == "default:snowblock"
		or node.name == "ethereal:icebrick"
		or node.name == "ethereal:snowbrick" then
			minetest.swap_node(pos, {name = water_node.."_source"})

		elseif node.name == "default:snow" then
			minetest.swap_node(pos, {name = water_node.."_flowing"})

		elseif node.name == "default:dirt_with_snow" then
			minetest.swap_node(pos, {name = "default:dirt_with_grass"})
		end

		ethereal.check_falling(pos)
	end,
})
]]--
