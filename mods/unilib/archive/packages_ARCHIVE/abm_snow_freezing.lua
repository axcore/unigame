---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
--Freezing
--Water freezes when in contact with snow.
minetest.register_abm({
	nodenames = {"default:water_source"},
	-- Added "group:icemaker" and snowbrick. ~ LazyJ
	neighbors = {"default:snow", "default:snowblock", "snow:snow_brick", "group:icemaker"},
	interval = 20,
	chance = 4,
	action = function(pos)
		minetest.add_node(pos,{name="default:ice"})
	end,
})

--Freeze Ice according to it's param2 value.
minetest.register_abm({
	nodenames = {"default:ice"},
	neighbors = {"default:water_source"},
	interval = 20,
	chance = 4,
	action = function(pos, node)
		if node.param2 == 0 then
			return
		end
		for l = 0,1 do
			for i = -1,1,2 do
				for _,p in pairs({
					{x=pos.x+i, z=pos.z-l*i},
					{x=pos.x+l*i, z=pos.z+i}
				}) do
					if math.random(2) == 2 then
						p.y = pos.y
						if minetest.get_node(p).name == "default:water_source" then
							minetest.add_node(p, {
								name = "default:ice",
								param2 = math.random(0,node.param2-1)
							})
						end
					end
				end
			end
		end
		if math.random(8) == 8 then
			minetest.add_node(pos, {name="default:water_source"})
		else
			node.param2 = 0
			minetest.add_node(pos, node)
		end
	end,
})
]]--
