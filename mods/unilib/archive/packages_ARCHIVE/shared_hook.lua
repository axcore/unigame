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
hook={
	tmp_throw={},
	tmp_throw_timer=0,
	tmp_time= tonumber(minetest.settings:get("item_entity_ttl")),
	pvp = minetest.settings:get_bool("enable_pvp") == true,
}

if hook.tmp_time=="" or hook.tmp_time==nil then
	hook.tmp_time=890
else
	hook.tmp_time=hook.tmp_time-10
end

hook.is_hook=function(pos,name)
	if not (name and minetest.is_protected(pos,name)) then
		local def = minetest.registered_nodes[minetest.get_node(pos).name]
		if def and def.name == "hook:hooking" or (def.buildable_to and not (def.liquidtype == "source" and def.paramtype2 == "none")) then
			if not (def.name == "hook:hooking" and minetest.get_meta(pos):get_int("a") ~= 0) then
				return true
			end
		end
	end
	return false
end

hook.punch=function(ob1,ob2,hp)
	ob2:punch(ob1,1,{full_punch_interval=1,damage_groups={fleshy=hp}})
end

hook.slingshot_def=function(pos,n)
	local nn=minetest.get_node(pos).name
	return (minetest.registered_nodes[nn] and minetest.registered_nodes[nn][n])
end

minetest.register_node("hook:hooking", {
	description = "Hooking",
	drawtype = "mesh",
	mesh="hook_hook.obj",
	tiles = {"hook_iron.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable=false,
	drop = "",
	sunlight_propagates = false,
	groups = {not_in_creative_inventory=1,rope=1, dig_immediate=3,rope=1},
	can_dig = function(pos, player)
		return minetest.get_item_group(minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name,"rope") == 0
	end,
	on_timer = function (pos, elapsed)
		if minetest.get_item_group(minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name,"rope") == 0 then
			minetest.remove_node(pos)
		else
			return true
		end
	end,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.5, 0.0625, -0.49, -0.375}
		}
	},
})

minetest.register_entity("hook:power",{
	hp_max = 100,
	physical = true,
	collisionbox = {-0.2,-0.2,-0.2, 0.2,0.2,0.2},
	visual = "mesh",
	mesh = "hook_hook.obj",
	visual_size = {x=10, y=10},
	textures = {"hook_iron.png"},
	is_visible = true,
	makes_footstep_sound = false,
	timer2=0,
	d=0,
	uname="",
	locked=false,
on_activate=function(self, staticdata)
	if hook.user==nil then
		self.object:remove()
		return self
	end
	self.d=hook.user:get_look_dir()
	self.fd=minetest.dir_to_facedir(self.d)
	self.uname=hook.user:get_player_name()
	self.user=hook.user
	self.locked=hook.locked
	hook.user=nil
	if self.fd==3 then
		self.fd=1
	elseif self.fd==1 then
		self.fd=3
	elseif self.fd==2 then
		self.fd=0
	elseif self.fd==0 then
		self.fd=2
	end
end,
on_step= function(self, dtime)
	self.timer2=self.timer2+dtime
	local pos=self.object:get_pos()
	local kill=0
	if hook.slingshot_def({x=pos.x+self.d.x,y=pos.y,z=pos.z+self.d.z},"walkable") and not hook.slingshot_def({x=pos.x+self.d.x,y=pos.y+1,z=pos.z+self.d.z},"walkable")
	and hook.is_hook(pos,self.uname) and hook.is_hook({x=pos.x,y=pos.y+1,z=pos.z},self.uname) then
		kill=1
		if self.locked then
			if self.user:get_inventory():contains_item("main", "hook:climb_rope_locked")==false then
				self.object:remove()
				return self
			end
			if hook.is_hook({x=pos.x,y=pos.y+1,z=pos.z},self.uname) then
				minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z},{name = "hook:hooking",param2=self.fd})
				minetest.get_meta({x=pos.x,y=pos.y+1,z=pos.z}):set_int("a",1)
			else
				return self
			end
			self.user:get_inventory():remove_item("main", "hook:climb_rope_locked")
			for i=0,20,1 do
				if hook.is_hook({x=pos.x,y=pos.y-i,z=pos.z},self.uname) then
					minetest.set_node({x=pos.x,y=pos.y-i,z=pos.z},{name = "hook:rope3",param2=self.fd})
				else
					break
				end
				minetest.get_meta({x=pos.x,y=pos.y-i,z=pos.z}):set_string("owner",self.uname)
			end
		else
			if self.user:get_inventory():contains_item("main", "hook:climb_rope")==false then
				self.object:remove()
				return self
			end
			if hook.is_hook({x=pos.x,y=pos.y+1,z=pos.z},self.uname) then
				minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z},{name = "hook:hooking",param2=self.fd})
				minetest.get_meta({x=pos.x,y=pos.y+1,z=pos.z}):set_int("a",1)
			else
				return self
			end
			self.user:get_inventory():remove_item("main", "hook:climb_rope")
			for i=0,20,1 do
				if hook.is_hook({x=pos.x,y=pos.y-i,z=pos.z},self.uname) then
					minetest.set_node({x=pos.x,y=pos.y-i,z=pos.z},{name = "hook:rope2",param2=self.fd})
				else
					break
				end
			end
		end
	end
	if self.timer2>3 or kill==1 then
		self.object:remove()

	end
	return self
end,
})

minetest.register_globalstep(function(dtime) 
	hook.tmp_throw_timer=hook.tmp_throw_timer+dtime
	if hook.tmp_throw_timer<0.1 then return end
	hook.tmp_throw_timer=0
	for i, t in pairs(hook.tmp_throw) do
		t.timer=t.timer-0.25
		if t.timer<=0 or t.ob==nil or t.ob:get_pos()==nil then table.remove(hook.tmp_throw,i) return end
		for ii, ob in pairs(minetest.get_objects_inside_radius(t.ob:get_pos(), 1.5)) do
			if (not ob:get_luaentity()) or (ob:get_luaentity() and (ob:get_luaentity().name~="__builtin:item")) then
				if (not ob:is_player()) or (ob:is_player() and ob:get_player_name(ob)~=t.user and hook.pvp) then
					ob:set_hp(ob:get_hp()-5)
					hook.punch(ob,ob,4)
					t.ob:set_velocity({x=0, y=0, z=0})
					if ob:get_hp()<=0 and ob:is_player()==false then ob:remove() end
					t.ob:set_acceleration({x=0, y=-10,z=0})
					t.ob:set_velocity({x=0, y=-10, z=0})
					table.remove(hook.tmp_throw,i)
					break
				end
			end
		end
	end
end)
]]--
