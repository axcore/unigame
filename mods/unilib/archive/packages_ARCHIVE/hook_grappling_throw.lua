---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("hook:climb_rope", {
	description = "Climb rope",
	range = 2,
	inventory_image = "hook_rope2.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type~="node" then
			hook.user=user
			hook.locked=false
			local pos=user:get_pos()
			local d=user:get_look_dir()
			local m=minetest.add_entity({x=pos.x,y=pos.y+1.5,z=pos.z}, "hook:power")
			m:set_velocity({x=d.x*15, y=d.y*15, z=d.z*15})
			m:set_acceleration({x=0, y=-5, z=0})
			minetest.sound_play("hook_throw", {pos=pos, gain = 1.0, max_hear_distance = 5,})
			return itemstack
		else
			local pos=pointed_thing.under
			local d=minetest.dir_to_facedir(user:get_look_dir())
			local z=0
			local x=0
			local name=user:get_player_name()
			if hook.slingshot_def(pos,"walkable") then
				if d==0 then z=1 end
				if d==2 then z=-1 end
				if d==1 then x=1 end
				if d==3 then x=-1 end
				if hook.is_hook({x=pos.x+x,y=pos.y,z=pos.z+z},name) and hook.is_hook({x=pos.x+x,y=pos.y+1,z=pos.z+z},name) then
					minetest.set_node({x=pos.x+x,y=pos.y+1,z=pos.z+z},{name = "hook:hooking",param2=d})
					minetest.get_meta({x=pos.x+x,y=pos.y+1,z=pos.z+z}):set_int("a",1)
				else
					return itemstack
				end
				itemstack:take_item()
				for i=0,20,1 do
					if hook.is_hook({x=pos.x+x,y=pos.y-i,z=pos.z+z},name) then minetest.set_node({x=pos.x+x,y=pos.y-i,z=pos.z+z},{name = "hook:rope2",param2=d}) else return itemstack end
				end
			end
			return itemstack
		end
	end
})
minetest.register_craft({
	output = "hook:climb_rope",
	recipe = {
		{"","default:steel_ingot",""},
		{"","default:steelblock",""},
		{"","default:steel_ingot",""},
	}
})

minetest.register_node("hook:rope2", {
	description = "Rope",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.5, 0.0625, 0.5, -0.375}
		}
	},
	tiles = {"hook_rope.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	liquid_viscosity = 1,
	liquidtype = "source",
	liquid_alternative_flowing="hook:rope2",
	liquid_alternative_source="hook:rope2",
	liquid_renewable = false,
	liquid_range = 0,
	sunlight_propagates = false,
	walkable = false,
	is_ground_content = false,
	groups = {not_in_creative_inventory=1,rope=1, dig_immediate = 3,},
	on_punch = function(pos, node, puncher, pointed_thing)
		if minetest.is_protected(pos,puncher:get_player_name()) then
			return false
		end
		puncher:get_inventory():add_item("main", ItemStack("hook:climb_rope"))
		local n2d = {["hook:rope2"]=true,["hook:hooking"]=true}
		for i=0,21 do
			local p = {x=pos.x,y=pos.y+i,z=pos.z}
			if n2d[minetest.get_node(p).name] then
				minetest.remove_node(p)
			else
				break
			end
		end
		for i=1,21 do
			local p = {x=pos.x,y=pos.y-i,z=pos.z}
			if n2d[minetest.get_node(p).name] then
				minetest.remove_node(p)
			else
				break
			end
		end
	end,
	sounds = {footstep = {name = "hook_rope", gain = 1}}
})
]]--
