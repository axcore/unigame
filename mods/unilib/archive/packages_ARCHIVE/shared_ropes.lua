---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local data = {}
local c_air = minetest.get_content_id("air")

local rope_box_data = {
{
	node={
		{-0.125, -0.125, -0.25, 0.125, 0.125, 0.25}, -- pulley
		{-0.125, -0.25, -0.125, 0.125, 0.25, 0.125}, -- pulley
		{-0.125, -0.1875, -0.1875, 0.125, 0.1875, 0.1875}, -- pulley_core
		{-0.1875, -0.5, -0.125, -0.125, 0.125, 0.125}, -- support
		{0.125, -0.5, -0.125, 0.1875, 0.125, 0.125}, -- support
	},
	--selection = {-0.1875, -0.5, -0.25, 0.1875, 0.25, 0.25}, -- selection
	tiles = 1,
},
{	
	node={
		{-0.1875, -0.125, -0.25, 0.1875, 0.125, 0.25}, -- pulley
		{-0.1875, -0.25, -0.125, 0.1875, 0.25, 0.125}, -- pulley
		{-0.1875, -0.1875, -0.1875, 0.1875, 0.1875, 0.1875}, -- pulley_core
		{-0.25, -0.5, -0.125, -0.1875, 0.125, 0.125}, -- support
		{0.1875, -0.5, -0.125, 0.25, 0.125, 0.125}, -- support
	},
	--selection = {-0.1875, -0.5, -0.25, 0.1875, 0.25, 0.25}, -- selection
	tiles = 2,
},
{	
	node={
		{-0.25, -0.125, -0.25, 0.25, 0.125, 0.25}, -- pulley
		{-0.25, -0.25, -0.125, 0.25, 0.25, 0.125}, -- pulley
		{-0.25, -0.1875, -0.1875, 0.25, 0.1875, 0.1875}, -- pulley_core
		{-0.3125, -0.5, -0.125, -0.25, 0.125, 0.125}, -- support
		{0.25, -0.5, -0.125, 0.3125, 0.125, 0.125}, -- support
	},
	--selection = {-0.3125, -0.5, -0.25, 0.3125, 0.25, 0.25}, -- selection
	tiles = 3,
},
{	
	node={
		{-0.3125, -0.125, -0.25, 0.3125, 0.125, 0.25}, -- pulley
		{-0.3125, -0.25, -0.125, 0.3125, 0.25, 0.125}, -- pulley
		{-0.3125, -0.1875, -0.1875, 0.3125, 0.1875, 0.1875}, -- pulley_core
		{-0.375, -0.5, -0.125, -0.3125, 0.125, 0.125}, -- support
		{0.3125, -0.5, -0.125, 0.375, 0.125, 0.125}, -- support
	},
	--selection = {-0.375, -0.5, -0.25, 0.375, 0.25, 0.25}, -- selection
	tiles = 4,
},
{	
	node={
		{-0.375, -0.125, -0.25, 0.375, 0.125, 0.25}, -- pulley
		{-0.375, -0.25, -0.125, 0.375, 0.25, 0.125}, -- pulley
		{-0.375, -0.1875, -0.1875, 0.375, 0.1875, 0.1875}, -- pulley_core
		{-0.4375, -0.5, -0.125, -0.375, 0.125, 0.125}, -- support
		{0.375, -0.5, -0.125, 0.4375, 0.125, 0.125}, -- support
	},
	--selection = {-0.4375, -0.5, -0.25, 0.4375, 0.25, 0.25}, -- selection
	tiles = 5,
},
{
	node={
		{-0.1875, -0.1875, -0.3125, 0.1875, 0.1875, 0.3125}, -- pulley
		{-0.1875, -0.3125, -0.1875, 0.1875, 0.3125, 0.1875}, -- pulley
		{-0.1875, -0.25, -0.25, 0.1875, 0.25, 0.25}, -- pulley_core
		{-0.25, -0.5, -0.125, -0.1875, 0.125, 0.125}, -- support
		{0.1875, -0.5, -0.125, 0.25, 0.125, 0.125}, -- support
	},
	--selection = {-0.1875, -0.5, -0.3125, 0.1875, 0.3125, 0.3125}, -- selection
	tiles = 2,
},
{	
	node={
		{-0.25, -0.1875, -0.3125, 0.25, 0.1875, 0.3125}, -- pulley
		{-0.25, -0.3125, -0.1875, 0.25, 0.3125, 0.1875}, -- pulley
		{-0.25, -0.25, -0.25, 0.25, 0.25, 0.25}, -- pulley_core
		{-0.3125, -0.5, -0.125, -0.25, 0.125, 0.125}, -- support
		{0.25, -0.5, -0.125, 0.3125, 0.125, 0.125}, -- support
	},
	--selection = {-0.3125, -0.5, -0.3125, 0.3125, 0.3125, 0.3125}, -- selection
	tiles = 3,
},
{	
	node={
		{-0.3125, -0.1875, -0.3125, 0.3125, 0.1875, 0.3125}, -- pulley
		{-0.3125, -0.3125, -0.1875, 0.3125, 0.3125, 0.1875}, -- pulley
		{-0.3125, -0.25, -0.25, 0.3125, 0.25, 0.25}, -- pulley_core
		{-0.375, -0.5, -0.125, -0.3125, 0.125, 0.125}, -- support
		{0.3125, -0.5, -0.125, 0.375, 0.125, 0.125}, -- support
	},
	--selection = {-0.375, -0.5, -0.3125, 0.375, 0.3125, 0.3125}, -- selection
	tiles = 4,
},
{	
	node={
		{-0.375, -0.1875, -0.3125, 0.375, 0.1875, 0.3125}, -- pulley
		{-0.375, -0.3125, -0.1875, 0.375, 0.3125, 0.1875}, -- pulley
		{-0.375, -0.25, -0.25, 0.375, 0.25, 0.25}, -- pulley_core
		{-0.4375, -0.5, -0.125, -0.375, 0.125, 0.125}, -- support
		{0.375, -0.5, -0.125, 0.4375, 0.125, 0.125}, -- support
	},
	--selection_bottom = {-0.4375, -0.5, -0.3125, 0.4375, 0.3125, 0.3125}, -- selection
	tiles = 5,
}
}

local function rope_box_tiles(count, tint)
	return {
		string.format("ropes_ropebox_front_%i.png^[colorize:%s^ropes_ropebox_front_%i.png^ropes_%i.png", count, tint, count, count),
		string.format("ropes_ropebox_front_%i.png^[colorize:%s^ropes_ropebox_front_%i.png^ropes_%i.png", count, tint, count, count),
		string.format("ropes_ropebox_side.png^[colorize:%s^ropes_ropebox_side.png", tint),
		string.format("ropes_ropebox_side.png^[colorize:%s^ropes_ropebox_side.png", tint),
		string.format("ropes_ropebox_front_%i.png^[colorize:%s^ropes_ropebox_front_%i.png^ropes_%i.png", count, tint, count, count),
		string.format("ropes_ropebox_front_%i.png^[colorize:%s^ropes_ropebox_front_%i.png^ropes_%i.png", count, tint, count, count),
	}
end

ropes.move_players_down = function(pos, radius)
	local all_objects = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+radius, z=pos.z}, radius)
	local players = {}
	local _,obj
	for _,obj in pairs(all_objects) do
		if obj:is_player() then
			local obj_pos = obj:get_pos()
			if math.abs(obj_pos.x-pos.x) < 0.5 and math.abs(obj_pos.z-pos.z) < 0.5 then
				obj:set_pos({x=obj_pos.x, y=obj_pos.y-1, z=obj_pos.z}, true)
			end
		end
	end
end

ropes.can_place_rope_in_node = function(target_node_name)
	if ropes.can_extend_into_nodes[target_node_name] == true then
		return true
	end
	local target_def = minetest.registered_nodes[target_node_name]
	if target_def then
		if target_def.drawtype == "airlike" and ropes.can_extend_into_airlike then
			return true
		end
		if target_def.groups and target_def.groups.ropes_can_extend_into then
			return true
		end
	end
	return false
end

ropes.make_rope_on_timer = function(rope_node_name)
	return function(pos, elapsed)
		local currentend = minetest.get_node(pos)
		local currentmeta = minetest.get_meta(pos)
		local currentlength = currentmeta:get_int("length_remaining")
		local placer_name = currentmeta:get_string("placer")
		local newpos = {x=pos.x, y=pos.y-1, z=pos.z}
		local newnode = minetest.get_node(newpos)
		local oldnode = minetest.get_node(pos)
		if currentlength > 1 and (not minetest.is_protected(newpos, placer_name)
		or minetest.check_player_privs(placer_name, "protection_bypass")) then
			if ropes.can_place_rope_in_node(newnode.name) then
				minetest.add_node(newpos, {name=currentend.name, param2=oldnode.param2})
				local newmeta = minetest.get_meta(newpos)
				newmeta:set_int("length_remaining", currentlength-1)
				newmeta:set_string("placer", placer_name)
				minetest.set_node(pos, {name=rope_node_name, param2=oldnode.param2})
				ropes.move_players_down(pos, 1)
			else
				local timer = minetest.get_node_timer( pos )
				timer:start( 1 )
			end
		end
	end
end

local data = {}
local c_air = minetest.get_content_id("air")

ropes.destroy_rope = function(pos, nodes)
	local top = pos.y
	local bottom = pos.y-15
	local voxel_manip = minetest.get_voxel_manip()

	local finished = false
	local ids_to_destroy = {}
	for _, node in pairs(nodes) do
		if minetest.registered_nodes[node] then
			ids_to_destroy[minetest.get_content_id(node)] = true
		end
	end
	
	while not finished do
		local emin, emax = voxel_manip:read_from_map({x=pos.x, y=bottom, z=pos.z}, {x=pos.x, y=top, z=pos.z})
		voxel_manip:get_data(data)
		local voxel_area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
		bottom = emin.y			
		for y = top, bottom, -1 do
			local index = voxel_area:index(pos.x, y, pos.z)
			if ids_to_destroy[data[index]\] then
				data[index] = c_air
			else
				finished = true
				break
			end
		end
		voxel_manip:set_data(data)
		voxel_manip:write_to_map()
		voxel_manip:update_map()
		top = bottom - 1
		bottom = bottom - 15
	end
end

ropes.hanging_after_destruct = function(pos, top_node, middle_node, bottom_node)
	local node = minetest.get_node(pos)
	if node.name == top_node or node.name == middle_node or node.name == bottom_node then
		return -- this was done by another ladder or rope node changing this one, don't react
	end

	pos.y = pos.y + 1 -- one up
	local node_above = minetest.get_node(pos)
	if node_above.name == middle_node then
		minetest.swap_node(pos, {name=bottom_node, param2=node_above.param2})
	end
	
	pos.y = pos.y - 2 -- one down
	local node_below = minetest.get_node(pos)
	if node_below.name == middle_node then
		ropes.destroy_rope(pos, {middle_node, bottom_node})
	elseif node_below.name == bottom_node then
		minetest.swap_node(pos, {name="air"})
	end
end

local ladder_extender = function(pos, node, clicker, itemstack, pointed_thing, ladder_node, standing_limit)
	-- on_rightclick can be called by other mods, make sure we have all the parameters we need
	if pointed_thing == nil or itemstack == nil then
		return itemstack
	end

	local clicked_stack = ItemStack(itemstack)
	
	-- true if we're pointing up at the ladder from below and there's a buildable space below it
	-- this check allows us to extend ladders downward
	local pointing_directly_below = 
		pointed_thing.above.x == pos.x and
		pointed_thing.above.z == pos.z and
		pointed_thing.above.y == pos.y - 1 and
		minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].buildable_to
	
	if clicked_stack:get_name() == ladder_node and not pointing_directly_below then
		local param2 = minetest.get_node(pos).param2
		local dir = minetest.facedir_to_dir(param2)
		local scan_limit = pos.y + 6 -- Only add ladder segments up to five nodes above the one clicked on
		pos.y = pos.y + 1
		while pos.y < scan_limit and minetest.get_node(pos).name == ladder_node do
			param2 = minetest.get_node(pos).param2
			pos.y = pos.y + 1
		end
		if pos.y < scan_limit and minetest.registered_nodes[minetest.get_node(pos).name].buildable_to then
			
			-- scan downward behind the ladder to find support
			local behind_pos = vector.add(pos, minetest.facedir_to_dir(param2))
			local target_height = pos.y - standing_limit - 1
			while behind_pos.y > target_height and minetest.registered_nodes[minetest.get_node(behind_pos).name].buildable_to do
				behind_pos.y = behind_pos.y - 1
			end
		
			-- If there's enough support, build a new ladder segment
			if behind_pos.y > target_height then
				if minetest.is_protected(pos, clicker:get_player_name()) then
					minetest.record_protection_violation(clicker:get_player_name())
				else
					minetest.set_node(pos, {name=ladder_node, param2=param2})
					if not minetest.settings:get_bool("creative_mode") then
						clicked_stack:take_item(1)
					end
				end
			end
		end
	elseif clicked_stack:get_definition().type == "node" then
		return minetest.item_place_node(itemstack, clicker, pointed_thing)
	end
	return clicked_stack
end

local function register_rope_block(multiple, max_multiple, name_prefix, node_prefix, tint, flammable)
	local node_name = string.format("ropes:%s%irope_block", node_prefix, multiple)
	local rope_block_def = {
		description = S("@1 Ropebox @2m", name_prefix, ropes.ropeLength*multiple),
		_doc_items_create_entry = false,
		drawtype="nodebox",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		climbable = true,
		tiles = rope_box_tiles(rope_box_data[multiple].tiles, tint),
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = rope_box_data[multiple].node
		},
		selection_box = {type="regular"},
		collision_box = {type="regular"},
		groups = {attached_node = 1, choppy=2, oddly_breakable_by_hand=1, rope_block = 1},
		
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type == "node" then
				local target_node = minetest.get_node(pointed_thing.under)
				local target_def = minetest.registered_nodes[target_node.name]
				if target_def.walkable == false then
					return itemstack
				end
			end
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	
		after_place_node = function(pos, placer)
			local pos_below = {x=pos.x, y=pos.y-1, z=pos.z}
			local placer_name = placer:get_player_name()
			
			if minetest.is_protected(pos_below, placer_name) and not minetest.check_player_privs(placer, "protection_bypass") then
				return
			end
		
			local node_below = minetest.get_node(pos_below)
			if ropes.can_place_rope_in_node(node_below.name) then
				minetest.add_node(pos_below, {name="ropes:rope_bottom"})
				local meta = minetest.get_meta(pos_below)
				meta:set_int("length_remaining", ropes.ropeLength*multiple)
				meta:set_string("placer", placer:get_player_name())
			end
		end,
		
		after_destruct = function(pos)
			local pos_below = {x=pos.x, y=pos.y-1, z=pos.z}
			ropes.destroy_rope(pos_below, {'ropes:rope', 'ropes:rope_bottom'})
		end
	}	
	
	-- If this number is higher than permitted, we still want to register the block (in case
	-- some were already placed in-world) but we want to hide it from creative inventory
	-- and if someone digs it we want to disintegrate it into its component parts to prevent
	-- reuse.
	if multiple > max_multiple then
		rope_block_def.groups.not_in_creative_inventory = 1
		rope_block_def.drop = string.format("ropes:%s1rope_block %i", node_prefix, multiple)
	end
	
	if flammable then
		rope_block_def.groups.flammable = flammable
		
		minetest.register_craft({
			type = "fuel",
			recipe = node_name,
			burntime = ropes.rope_burn_time * multiple + ropes.wood_burn_time,
		})
	end
	
	minetest.register_node(node_name, rope_block_def)
	
	if (multiple ~= 1) then
		-- Only register a recipe to craft this if it's within the permitted multiple range
		if multiple <= max_multiple then
			for i = 1, multiple-1 do
				local rec = {string.format("ropes:%s%irope_block", node_prefix, i)}
				for n = 1, multiple-i do
					table.insert(rec, "ropes:ropesegment")
				end
				minetest.register_craft({
					output = node_name,
					type = "shapeless",
					recipe = rec
				})
			end
		end
	
		-- Always allow players to disintegrate this into component parts, in case
		-- there were some in inventory and the setting was changed.
		minetest.register_craft({
			output = "ropes:ropesegment",
			type = "shapeless",
			recipe =  {
				node_name
			},
			replacements = {
				{node_name, string.format('ropes:%s%irope_block', node_prefix, multiple-1)},
			},
		})
	end
	
	if minetest.get_modpath("doc") then
		doc.add_entry_alias("nodes", "ropes:rope", "nodes", node_name)
	end
end
]]--
