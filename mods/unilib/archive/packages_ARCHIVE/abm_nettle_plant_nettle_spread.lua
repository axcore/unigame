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
local function count_nodes(pos, name)
	local result = 0
	for x_ = pos.x-1, pos.x+1 do
		for y_ = pos.y-1, pos.y+1 do
			for z_ = pos.z-1, pos.z+1 do
				if minetest.get_node({x=x_, y=y_, z=z_}).name == name then
					result = result+1
				end
			end
		end
	end
	return result
end

local function has_neighbour(pos, name)
	local result = 0
	for x_ = pos.x-1, pos.x+1 do
		for y_ = pos.y-1, pos.y+1 do
			for z_ = pos.z-1, pos.z+1 do
				if minetest.get_node({x=x_, y=y_, z=z_}).name == name then
					return true
				end
			end
		end
	end
	return false
end

minetest.register_abm({
	nodenames = {"group:nettle_weed"},
	interval = 120,
	chance = 10,
	action = function(pos, node)
		if node.name == "nettle:nettle" then
			if count_nodes(pos, "nettle:nettle") >= 4 then
				minetest.set_node(pos, {name = "nettle:carduus"})
				return
			end
			if has_neighbour(pos, "nettle:impatiens") then
				minetest.set_node(pos, {name = "nettle:impatiens"})
				return
			end
			if has_neighbour(pos, "nettle:scotch_broom") then
				minetest.set_node(pos, {name = "nettle:cleavers"})
				return
			end
		elseif node.name == "nettle:carduus" then
			if count_nodes(pos, "nettle:carduus") >= 2 then
				minetest.set_node(pos, {name = "nettle:scotch_broom"})
				return
			end
		elseif node.name == "nettle:cleavers" then
			if count_nodes(pos, "nettle:cleavers") >= 4 then
				minetest.set_node(pos, {name = "nettle:giant_hogweed"})
				return
			end
			if has_neighbour(pos, "nettle:nettle") then
				minetest.set_node(pos, {name = "nettle:nettle"})
				return
			end
			if has_neighbour(pos, "nettle:giant_hogweed") then
				minetest.set_node(pos, {name = "nettle:impatiens"})
				return
			end
		elseif node.name == "nettle:impatiens" then
			if has_neighbour(pos, "nettle:cleavers") then
				minetest.set_node(pos, {name = "nettle:cleavers"})
				return
			end
			if has_neighbour(pos, "nettle:carduus") then
				minetest.set_node(pos, {name = "nettle:nettle"})
				return
			end
		elseif node.name == "nettle:scotch_broom" then
			local above = {x=pos.x, y=pos.y+1, z=pos.z}
			if minetest.get_node(above).name ~= "air" then
				return
			end
			for x_ = pos.x-1, pos.x+1 do
				for z_ = pos.z-1, pos.z+1 do
					if minetest.get_node({x=x_, y=pos.y, z=z_}).name == "air" then
						return;
					end
				end
			end
			minetest.set_node(above, {name = "nettle:scotch_broom"})
		end
	end
})
]]--
