---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local frequency = 200

minetest.register_on_generated(function(minp, maxp)
	if maxp.y > 0 then
		return
	end
	local stone = minetest.find_nodes_in_area_under_air(minp, maxp,
		{"default:stone", "default:desert_stone"})
	for n = 1, #stone do
		if math.random(1, frequency) == 1 then
			local pos = {x = stone[n].x, y = stone[n].y + 1, z = stone[n].z }
			if minetest.find_node_near(pos, 3, {"group:lava"}) then
				minetest.add_node(pos, {name = "moreplants:firefung"})
			elseif minetest.get_node_light(pos, nil) < 8 then
				if minetest.find_node_near(pos, 3, {"group:water"}) then
					minetest.add_node(pos, {name = "moreplants:bluemush"})
				else
					minetest.add_node(pos, {name = "moreplants:caveflower"})
				end
			end
		end
	end
end)
]]--
