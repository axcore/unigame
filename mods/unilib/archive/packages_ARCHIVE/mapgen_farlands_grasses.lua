---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_on_generated(function(minp, maxp)
	if maxp.y < -20 or maxp.y > 1000 then
		return
	end
	local dirt = minetest.find_nodes_in_area(minp, maxp,
		{"mapgen:dirty_water_source"})
	for n = 1, #dirt do
			local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
			local name = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
				if name == "mapgen:lavender_flower" or name == "mapgen:swamp_grass_1" or name == "mapgen:giantgrass" or name == "mapgen:swamp_grass_2" or name == "mapgen:swamp_grass_3" or name == "mapgen:swamp_grass_4" or name == "mapgen:swamp_grass_5" then
					minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
				end
	end
end)
]]--
