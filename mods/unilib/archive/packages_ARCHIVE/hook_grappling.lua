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
minetest.register_tool("hook:hook", {
	description = "Hook with rope (hit a corner to climb)",
	inventory_image = "hook_hook.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type~="node" then return itemstack end
		local d=minetest.dir_to_facedir(user:get_look_dir())
		local pos=pointed_thing.above
		local pos2=pointed_thing.under
		local name=user:get_player_name()

		if hook.slingshot_def(pos2,"walkable") and
		hook.slingshot_def({x=pos.x,y=pos.y-1,z=pos.z},"walkable")==false
		and (hook.slingshot_def({x=pos2.x,y=pos2.y+1,z=pos2.z},"walkable")==false or minetest.get_node({x=pos2.x,y=pos2.y+1,z=pos2.z}).name=="default:snow") and
		hook.is_hook(pos,name) and
		hook.slingshot_def({x=pos.x,y=pos.y+1,z=pos.z},"walkable")==false then
			if d==3 then d=1
			elseif d==1 then d=3
			elseif d==2 then d=0
			elseif d==0 then d=2
			end
			if hook.is_hook({x=pos.x,y=pos.y+1,z=pos.z},name) then
				minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z},{name = "hook:hooking",param2=d})
				minetest.get_node_timer({x=pos.x,y=pos.y+1,z=pos.z}):start(3)
			else
				return itemstack
			end
			for i=0,-4, -1 do
				if hook.is_hook({x=pos.x,y=pos.y+i,z=pos.z},name) then
					minetest.set_node({x=pos.x,y=pos.y+i,z=pos.z}, {name = "hook:rope",param2=d})
				else
					return itemstack
				end
			end
		end
		return itemstack
	end
})
minetest.register_craft({
	output = "hook:hook",
	recipe = {
		{"","default:steel_ingot",""},
		{"","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","",""},
	}
})

minetest.register_tool("hook:hook_upgrade", {
	description = "Hook with rope (double)",
	range = 6,
	inventory_image = "hook_hookup.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type~="node" then return itemstack end
		local d=minetest.dir_to_facedir(user:get_look_dir())
		local pos=pointed_thing.above
		local pos2=pointed_thing.under
		local name=user:get_player_name()
		if hook.slingshot_def(pos2,"walkable") and
		hook.slingshot_def({x=pos.x,y=pos.y-1,z=pos.z},"walkable")==false and
		(hook.slingshot_def({x=pos2.x,y=pos2.y+1,z=pos2.z},"walkable")==false or minetest.get_node({x=pos2.x,y=pos2.y+1,z=pos2.z}).name=="default:snow") and
		hook.is_hook(pos,name) and
		hook.slingshot_def({x=pos.x,y=pos.y+1,z=pos.z},"walkable")==false then
			if d==3 then d=1
			elseif d==1 then d=3
			elseif d==2 then d=0
			elseif d==0 then d=2
			end
			if hook.is_hook({x=pos.x,y=pos.y+1,z=pos.z},name) then
				minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z},{name = "hook:hooking",param2=d})
				minetest.get_node_timer({x=pos.x,y=pos.y+1,z=pos.z}):start(3)
			else
				return itemstack
			end
			for i=0,-8, -1 do
				if hook.is_hook({x=pos.x,y=pos.y+i,z=pos.z},name) then
					minetest.set_node({x=pos.x,y=pos.y+i,z=pos.z}, {name = "hook:rope",param2=d})
				else
					return itemstack
				end
			end
		end
		return itemstack
	end
})
minetest.register_craft({
	output = "hook:hook_upgrade",
	recipe = {
		{"","hook:hook",""},
		{"","hook:hook",""},
		{"","default:steel_ingot",""},
	}
})

minetest.register_node("hook:rope", {
	description = "Rope (tempoary)",
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
	buildable_to = true,
	drop = "",
	liquid_viscosity = 1,
	liquidtype = "source",
	liquid_alternative_flowing="hook:rope",
	liquid_alternative_source="hook:rope",
	liquid_renewable = false,
	liquid_range = 0,
	sunlight_propagates = false,
	walkable = false,
	is_ground_content = false,
	groups = {not_in_creative_inventory=1,rope=1, dig_immediate = 3,},
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(3)
	end,
	on_timer = function (pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 3)) do
			if ob:is_player() then return true end
		end
		minetest.set_node(pos, {name = "air"})
		return false
	end,
	sounds = {footstep = {name = "hook_rope", gain = 1}}
})
]]--
