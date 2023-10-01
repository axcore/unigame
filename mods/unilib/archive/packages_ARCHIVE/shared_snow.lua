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
-- Checks if the snow level is even at any given pos.
-- Smooth Snow
local function uneven(pos)
	local num = minetest.get_node_level(pos)
	local get_node = minetest.get_node
	local add_node = minetest.add_node
	local foundx
	local foundz
	for z = -1,1 do
		for x = -1,1 do
			local p = {x=pos.x+x, y=pos.y, z=pos.z+z}
			local node = get_node(p)
			p.y = p.y-1
			local bnode = get_node(p)

			if node
			and minetest.registered_nodes[node.name]
			and minetest.registered_nodes[node.name].drawtype == "plantlike"
			and bnode.name == "default:dirt_with_grass" then
				add_node(p, {name="default:dirt_with_snow"})
				return true
			end

			p.y = p.y+1
			if not (x == 0 and z == 0)
			and node.name == "default:snow"
			and minetest.get_node_level(p) < num then
				foundx = x
				foundz = z
			elseif node.name == "air"
			and bnode.name ~= "air"
			and bnode.name ~= "default:snow" then
				p.y = p.y-1
				snow.place(p)
				return true
			end
		end
	end
	if foundx then
		local p = {x=pos.x+foundx, y=pos.y, z=pos.z+foundz}
		if not is_uneven(p) then
			minetest.add_node_level(p, 7)
		end
		return true
	end
end

if snow.smooth_snow then
	is_uneven = uneven
else
	is_uneven = function() end
end

local function snow_onto_dirt(pos)
	pos.y = pos.y - 1
	local node = minetest.get_node(pos)
	if node.name == "default:dirt_with_grass"
	or node.name == "default:dirt" then
		minetest.set_node(pos, {name = "default:dirt_with_snow"})
	end
end

--This function places snow checking at the same time for snow level and increasing as needed.
--This also takes into account sourrounding snow and makes snow even.
function snow.place(pos, disablesound)
	local node = minetest.get_node_or_nil(pos)

	--Oops, maybe there is no node?
	if not node
	or not minetest.registered_nodes[node.name] then
		return
	end

	if node.name == "default:snow" then
		local level = minetest.get_node_level(pos)
		if level < 63 then
			if minetest.get_item_group(minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name, "leafdecay") == 0
			and not is_uneven(pos) then
				if not disablesound then
				minetest.sound_play("default_snow_footstep", {pos=pos})
				end
				minetest.add_node_level(pos, 7)
			end
		elseif level == 63 then
			local p = minetest.find_node_near(pos, 10, "default:dirt_with_grass")
			if p
			and minetest.get_node_light(p, 0.5) == 15 then
				if not disablesound then
				minetest.sound_play("default_grass_footstep", {pos=pos})
				end
				minetest.place_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:snow"})
			else
				if not disablesound then
				minetest.sound_play("default_snow_footstep", {pos=pos})
				end
				minetest.add_node(pos, {name="default:snowblock"})
			end
		end
	elseif node.name ~= "default:ice"
	and minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name ~= "air" then
		local data = minetest.registered_nodes[node.name]
		local drawtype = data.drawtype
		if drawtype == "normal"
		or drawtype == "allfaces_optional" then
			pos.y = pos.y+1
			local sound = data.sounds
			if sound and not disablesound then
				sound = sound.footstep
				if sound then
					minetest.sound_play(sound.name, {pos=pos, gain=sound.gain})
				end
			end
			minetest.place_node(pos, {name="default:snow"})
		elseif drawtype == "plantlike" then
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "default:dirt_with_grass" then
				minetest.sound_play("default_grass_footstep", {pos=pos})
				minetest.add_node(pos, {name="default:dirt_with_snow"})
			end
		end
	end
end

minetest.register_craft({
	type = "cooking",
	cooktime = 12,
	output = "default:ice",
	recipe = "group:cooks_into_ice",
})
]]--
