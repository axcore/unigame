---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_abm({
	nodenames = {"group:spreading_dirt_type", "default:dirt", "group:ethereal_grass"},
	interval = 240,
	chance = 50,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		if minetest.get_node(above).name ~= "air" then
			return
		end
		local dirts = 0
		local airs = 0
		for x_ = pos.x-1, pos.x+1 do
			for y_ = pos.y-1, pos.y+1 do
				for z_ = pos.z-1, pos.z+1 do
					local nn = minetest.get_node({x=x_, y=y_, z=z_}).name
					if (nn == "default:dirt") or nn == ("default:stone") then
						dirts = dirts+1;
					end
					if (nn == "air") or (minetest.get_item_group(nn, "flora") > 0) then
						airs = airs+1;
					end
				end
			end
		end
		if (dirts < 14) and (airs < 14) then
			return
		end
		if (minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air") or (minetest.get_node_light(above, 0.5) < 8) then
			minetest.set_node(above, {name = "nettle:impatiens"})
		elseif minetest.get_node_light(above, 0.5) < 13 then
			minetest.set_node(above, {name = "nettle:cleavers"})
		else
			minetest.set_node(above, {name = "nettle:nettle"})
		end
	end
})
]]--
