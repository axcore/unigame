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
minetest.register_abm({
	label = "Ethereal drop torch",
	nodenames = {"default:torch", "default:torch_wall", "default:torch_ceiling"},
	neighbors = {"group:water"},
	interval = 5,
	chance = 1,
	catch_up = false,
	action = function(pos, node)

		local num = #minetest.find_nodes_in_area(
			{x = pos.x - 1, y = pos.y, z = pos.z},
			{x = pos.x + 1, y = pos.y, z = pos.z},
			{"group:water"})

		if num == 0 then
			num = num + #minetest.find_nodes_in_area(
				{x = pos.x, y = pos.y, z = pos.z - 1},
				{x = pos.x, y = pos.y, z = pos.z + 1},
				{"group:water"})
		end

		if num == 0 then
			num = num + #minetest.find_nodes_in_area(
				{x = pos.x, y = pos.y + 1, z = pos.z},
				{x = pos.x, y = pos.y + 1, z = pos.z},
				{"group:water"})
		end

		if num > 0 then

			minetest.set_node(pos, {name = "air"})

			minetest.sound_play("fire_extinguish_flame",
					{pos = pos, gain = 0.2, max_hear_distance = 10})

			minetest.add_item(pos, {name = "default:torch"})
		end
	end
})
]]--
