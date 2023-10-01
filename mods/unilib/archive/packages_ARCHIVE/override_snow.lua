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
local creative_mode = minetest.settings:get_bool"creative_mode"

local snowball_velocity, entity_attack_delay
local someone_throwing, just_acitvated

--The snowball Entity
local snow_snowball_ENTITY = {
	physical = false,
	timer = 0,
	collisionbox = {-5/16,-5/16,-5/16, 5/16,5/16,5/16},
}

local function update_snowball_vel(v)
	snowball_velocity = v
	local walkspeed = tonumber(minetest.settings:get"movement_speed_walk") or 4
	entity_attack_delay = (walkspeed+1)/v
end

local function get_gravity()
	local grav = tonumber(minetest.settings:get"movement_gravity") or 9.81
	return grav*snowball_gravity
end

--Shoot snowball
function snow.shoot_snowball(item, player)
	local addp = {y = 1.625} -- + (math.random()-0.5)/5}
	local dir = player:get_look_dir()
	local dif = 2*math.sqrt(dir.z*dir.z+dir.x*dir.x)
	addp.x = dir.z/dif -- + (math.random()-0.5)/5
	addp.z = -dir.x/dif -- + (math.random()-0.5)/5
	local pos = vector.add(player:get_pos(), addp)
	local obj = minetest.add_entity(pos, "snow:snowball_entity")
	obj:set_velocity(vector.multiply(dir, snowball_velocity))
	obj:set_acceleration({x=dir.x*-3, y=-get_gravity(), z=dir.z*-3})
	obj:get_luaentity().thrower = player:get_player_name()
	if creative_mode then
		if not someone_throwing then
			someone_throwing = true
			just_acitvated = true
		end
		return
	end
	item:take_item()
	return item
end

if creative_mode then
	local function update_step()
		local active
		for _,player in pairs(minetest.get_connected_players()) do
			if player:get_player_control().LMB then
				local item = player:get_wielded_item()
				local itemname = item:get_name()
				if itemname == "default:snow" then
					snow.shoot_snowball(nil, player)
					active = true
					break
				end
			end
		end

		-- disable the function if noone currently throws them
		if not active then
			someone_throwing = false
		end
	end

	-- do automatic throwing using minetest.after
	local function do_step()
		local timer
		-- only if one holds left click
		if someone_throwing
		and not just_acitvated then
			update_step()
			timer = 0.006
		else
			timer = 0.5
			just_acitvated = false
		end
		minetest.after(timer, do_step)
	end
	minetest.after(3, do_step)
end

function snow_snowball_ENTITY.on_activate(self)
	self.object:set_properties({textures = {"default_snowball.png^[transform"..math.random(0,7)}})
	self.object:set_acceleration({x=0, y=-get_gravity(), z=0})
	self.lastpos = self.object:get_pos()
	minetest.after(0.1, function(obj)
		if not obj then
			return
		end
		local vel = obj:get_velocity()
		if vel
		and vel.y ~= 0 then
			return
		end
		minetest.after(0, function(object)
			if not object then
				return
			end
			local vel_obj = object:get_velocity()
			if not vel_obj
			or vel_obj.y == 0 then
				object:remove()
			end
		end, obj)
	end, self.object)
end

--Snowball_entity.on_step()--> called when snowball is moving.
function snow_snowball_ENTITY.on_step(self, dtime)
	self.timer = self.timer + dtime
	if self.timer > 10 then
		-- 10 seconds is too long for a snowball to fly somewhere
		self.object:remove()
		return
	end

	if self.physical then
		local vel = self.object:get_velocity()
		local fell = vel.y == 0
		if not fell then
			if self.probably_stuck then
				self.probably_stuck = nil
			end
			return
		end
		if self.probably_stuck
		and vel.x == 0
		and vel.z == 0 then
			-- add a small velocity to move it from the corner
			vel.x = math.random() - 0.5
			vel.z = math.random() - 0.5
			self.object:set_velocity(vel)
			self.probably_stuck = nil
			return
		end
		local pos = vector.round(self.object:get_pos())
		if minetest.get_node(pos).name == "air" then
			pos.y = pos.y-1
			if minetest.get_node(pos).name == "air" then
				if vel.x == 0
				and vel.z == 0 then
					self.probably_stuck = true
				end
				return
			end
		end
		snow.place(pos)
		self.object:remove()
		return
	end

	local pos = vector.round(self.object:get_pos())
	if vector.equals(pos, self.lastpos) then
		return
	end
	if minetest.get_node(pos).name ~= "air" then
		self.object:set_acceleration({x=0, y=-get_gravity(), z=0})
		--self.object:set_velocity({x=0, y=0, z=0})
		pos = self.lastpos
		self.object:setpos(pos)
		minetest.sound_play("default_snow_footstep", {pos=pos, gain=vector.length(self.object:get_velocity())/30})
		self.object:set_properties({physical = true})
		self.physical = true
		return
	end
	self.lastpos = vector.new(pos)

	if self.timer < entity_attack_delay then
		return
	end
	for _,v in pairs(minetest.get_objects_inside_radius(pos, 1.73)) do
		local entity = v:get_luaentity()
		if v ~= self.object
		and entity then
			local entity_name = entity.name
			if v:is_player()
			or (entity_name ~= "snow:snowball_entity"
			and entity_name ~= "__builtin:item"
			and entity_name ~= "gauges:hp_bar") then
				local vvel = v:get_velocity() or v:get_player_velocity()
				local veldif = self.object:get_velocity()
				if vvel then
					veldif = vector.subtract(veldif, vvel)
				end
				local gain = vector.length(veldif)/20
				v:punch(
					(self.thrower and minetest.get_player_by_name(self.thrower))
						or self.object,
					1,
					{full_punch_interval=1, damage_groups = {fleshy=math.ceil(gain)}}
				)
				minetest.sound_play("default_snow_footstep", {pos=pos, gain=gain})

				-- spawn_falling_node
				local obj = minetest.add_entity(pos, "__builtin:falling_node")
				if obj then
					obj:get_luaentity():set_node{name = "default:snow"}
				else
					minetest.log("error", "Couldn't spawn falling node")
				end

				self.object:remove()
				return
			end
		end
	end
end

-- Override Default Nodes to Add Extra Functions

local groups = minetest.registered_nodes["default:ice"].groups
groups["melt"] = 1
minetest.override_item("default:ice", {
	drawtype = "glasslike",
	use_texture_alpha = "blend",
	param2 = 0,  --param2 is reserved for how much ice will freezeover.
	sunlight_propagates = true,  -- necessary for dirt_with_grass/snow/just dirt ABMs
	tiles = {"snow_ice.png^[brighten"},
	liquidtype = "none",
	groups = groups,
	on_construct = snow_onto_dirt,
	liquids_pointable = true,
	--Make ice freeze over when placed by a maximum of 10 blocks.
	after_place_node = function(pos)
		minetest.set_node(pos, {name="default:ice", param2=math.random(0,10)})
	end,
})

groups = minetest.registered_nodes["default:snowblock"].groups
for g,v in pairs({melts=1, icemaker=1, cooks_into_ice=1, falling_node=1}) do
	groups[g] = v
end
minetest.override_item("default:snowblock", {
	liquidtype = "none",
	paramtype = "light",
	sunlight_propagates = true,
	on_construct = snow_onto_dirt,
	groups = groups,
})

minetest.override_item("default:snow", {
	drop = {
		max_items = 2,
		items = {
			{items = {'snow:moss'}, rarity = 20,},
			{items = {'default:snow'},}
		}
	},
	leveled = 7,
	paramtype2 = "leveled",
	node_box = {
		type = "leveled",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
	collision_box = {
		type = "leveled",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
	selection_box = {
		type = "leveled",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
	groups = {cracky=3, crumbly=3, choppy=3, oddly_breakable_by_hand=3,
		falling_node=1, melts=2, float=1},
	sunlight_propagates = true,
	walkable = true,
	node_placement_prediction = "",
	on_construct = function(pos)
		pos.y = pos.y-1
		local node = minetest.get_node(pos)
		if node.name == "default:dirt_with_grass"
		or node.name == "default:dirt" then
			node.name = "default:dirt_with_snow"
			minetest.set_node(pos, node)
		end
	end,
	--Handle node drops due to node level.
	on_dig = function(pos, node, digger)
		local level = minetest.get_node_level(pos)
		minetest.node_dig(pos, node, digger)
		if minetest.get_node(pos).name ~= node.name then
			local inv = digger:get_inventory()
			if not inv then
				return
			end
			local left = inv:add_item("main", "default:snow "..tostring(level/7-1))
			if not left:is_empty() then
				minetest.add_item({
					x = pos.x + math.random()/2-0.25,
					y = pos.y + math.random()/2-0.25,
					z = pos.z + math.random()/2-0.25,
				}, left)
			end
		end
	end,
	--Manage snow levels.
	on_place = function(itemstack, player, pt)
		local oldnode_under = minetest.get_node_or_nil(pt.under)
		if not oldnode_under then
			return itemstack, false
		end

		local olddef_under = minetest.registered_nodes[oldnode_under.name]
		if not olddef_under then
			return itemstack, false
		end

		-- If node under is buildable_to, place into it instead (eg. snow)
		local pos, node
		if olddef_under.buildable_to then
			pos = pt.under
			node = oldnode_under
		else
			pos = pt.above
			node = minetest.get_node(pos)
			local def = minetest.registered_nodes[node.name]
			if not def
			or not def.buildable_to then
				return itemstack, false
			end
		end

		-- nil player can place (for snowballs)
		if player
		and minetest.is_protected(pos, player:get_player_name()) then
			return itemstack, false
		end

		if node.name ~= "default:snow" then
			if minetest.get_node{x=pos.x, y=pos.y-1, z=pos.z}.name ==
					"default:snow" then
				-- grow the snow below (fixes levelled problem)
				pos.y = pos.y - 1
			else
				-- place a snow
				return minetest.item_place_node(itemstack, player, pt)
			end
		end

		-- grow the snow
		local level = minetest.get_node_level(pos)
		level = level + 7
		if level < 64 then
			minetest.set_node_level(pos, level)
		else
			-- place a snowblock and snow onto it if possible
			local p = {x=pos.x, y=pos.y+1, z=pos.z}
			local def = minetest.registered_nodes[minetest.get_node(p).name]
			if not def
			or not def.buildable_to then
				return itemstack, false
			end

			minetest.set_node(pos, {name="default:snowblock"})
			minetest.set_node(p, {name="default:snow"})
			level = math.max(level - 64, 7)
			minetest.set_node_level(p, level)
		end

		itemstack:take_item()
		return itemstack, true
	end,
	on_use = snow.shoot_snowball
})

update_snowball_vel(snow.snowball_velocity)

minetest.register_entity("snow:snowball_entity", snow_snowball_ENTITY)
]]--
