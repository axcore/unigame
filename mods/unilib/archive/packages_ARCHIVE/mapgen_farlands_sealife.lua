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
if seaplants then
minetest.register_on_generated(function(minp, maxp)
	if maxp.y < -100 or maxp.y > 100 then
		return
	end
	local dirt = minetest.find_nodes_in_area(minp, maxp,
		{"default:sand"})
	for n = 1, #dirt do
		if math.random(1, 50) == 1 then
			local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
				if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:water_source" and minetest.get_node({x=pos.x, y=pos.y+3, z=pos.z}).name ~= "air" then
					if math.random(1,4) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:red_coral"})
					elseif math.random(1,4) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:big_coral"})
					elseif math.random(1,3) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:anemone"})
					elseif math.random(1,3) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:blue_coral"})
					else
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:orange_coral"})
					end
				end
		end
		if math.random(1, 20) == 1 then
			local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
			local num = math.random(1,2)
				if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:water_source" and minetest.get_node({x=pos.x, y=pos.y+3, z=pos.z}).name ~= "air" then
					if math.random(1,1) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:kelp"..num})
						if math.random(1,2) == 1 and minetest.get_node({x=pos.x, y=pos.y+4, z=pos.z}).name ~= "air" then
						minetest.add_node({x=pos.x, y=pos.y+2, z=pos.z}, {name = "mapgen:kelp"..num})
							if math.random(1,2) == 1 and minetest.get_node({x=pos.x, y=pos.y+5, z=pos.z}).name ~= "air" then
							minetest.add_node({x=pos.x, y=pos.y+3, z=pos.z}, {name = "mapgen:kelp"..num})
								if math.random(1,2) == 1 and minetest.get_node({x=pos.x, y=pos.y+6, z=pos.z}).name ~= "air" then
								minetest.add_node({x=pos.x, y=pos.y+4, z=pos.z}, {name = "mapgen:kelp"..num})
									if math.random(1,2) == 1 and minetest.get_node({x=pos.x, y=pos.y+7, z=pos.z}).name ~= "air" then
									minetest.add_node({x=pos.x, y=pos.y+5, z=pos.z}, {name = "mapgen:kelp"..num})
									end
								end
							end
						end
					end
				end
		end
	end
end)
end
]]--
