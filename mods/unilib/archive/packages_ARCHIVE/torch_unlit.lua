---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_torch
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function on_flood(pos, oldnode, newnode)

	minetest.add_item(pos, ItemStack("real_torch:torch 1"))

	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]

	-- return if torch is unlit already
	if oldnode.name == "real_torch:torch"
	or oldnode.name == "real_torch:torch_wall"
	or oldnode.name == "real_torch:torch_ceiling" then
		return false
	end

	-- play sound if torch is lit
	if not (nodedef and nodedef.groups and nodedef.groups.igniter
			and nodedef.groups.igniter > 0) then

		minetest.sound_play("default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1}, true)
	end

	-- Remove the torch node
	return false
end

-- unlit floor torch
minetest.register_node("real_torch:torch", {
	description = "Torch",
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "real_torch_on_floor.png",
	wield_image = "real_torch_on_floor.png",
	tiles = {
		{
			name = "real_torch_on_floor.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3
			}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 3,
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1},
	drop = "real_torch:torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8}
	},
	sounds = default.node_sound_wood_defaults(),

	on_place = function(itemstack, placer, pointed_thing)

		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]

		if def and def.on_rightclick and
			((not placer) or (placer and not placer:get_player_control().sneak)) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack

		if wdir == 0 then
			fakestack:set_name("real_torch:torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("real_torch:torch")
		else
			fakestack:set_name("real_torch:torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("real_torch:torch")

		return itemstack
	end,

	on_ignite = function(pos, igniter)

		local nod = minetest.get_node(pos)

		minetest.set_node(pos, {name = "default:torch", param2 = nod.param2})
	end,

	floodable = true,
	on_flood = on_flood
})
minetest.register_craft({
	output = "default:stick",
	recipe = {
		{"real_torch:torch", "real_torch:torch"},
		{"real_torch:torch", "real_torch:torch"}
	}
})

-- unlit wall torch
minetest.register_node("real_torch:torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {
		{
			name = "real_torch_on_floor.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3
			}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 3,
	sunlight_propagates = true,
	walkable = false,
	groups = {
		choppy = 2, dig_immediate = 3, flammable = 1, not_in_creative_inventory = 1,
		attached_node = 1
	},
	drop = "real_torch:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8}
	},
	sounds = default.node_sound_wood_defaults(),

	on_ignite = function(pos, igniter)

		local nod = minetest.get_node(pos)

		minetest.set_node(pos, {name = "default:torch_wall", param2 = nod.param2})
	end,

	floodable = true,
	on_flood = on_flood
})

-- unlit ceiling torch
minetest.register_node("real_torch:torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {
		{
			name = "real_torch_on_floor.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3
			}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 3,
	sunlight_propagates = true,
	walkable = false,
	groups = {
		choppy = 2, dig_immediate = 3, flammable = 1, not_in_creative_inventory = 1,
		attached_node = 1
	},
	drop = "real_torch:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8}
	},
	sounds = default.node_sound_wood_defaults(),

	on_ignite = function(pos, igniter)

		local nod = minetest.get_node(pos)

		minetest.set_node(pos, {name = "default:torch_ceiling", param2 = nod.param2})
	end,

	floodable = true,
	on_flood = on_flood
})

-- start timer on any already placed torches
minetest.register_lbm({
	name = "real_torch:convert_torch_to_node_timer",
	nodenames = {"default:torch", "default:torch_wall", "default:torch_ceiling"},
	action = function(pos)

		if not minetest.get_node_timer(pos):is_started() then

			minetest.get_node_timer(pos):start(
					math.random(real_torch.min_duration, real_torch.max_duration))
		end
	end
})

-- override default torches to burn out after 8-10 minutes
minetest.override_item("default:torch", {

	on_timer = function(pos, elapsed)

		local p2 = minetest.get_node(pos).param2

		minetest.set_node(pos, {name = "real_torch:torch", param2 = p2})

		minetest.sound_play("real_torch_burnout",
				{pos = pos, gain = 0.1, max_hear_distance = 10}, true)
	end,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(
				math.random(real_torch.min_duration, real_torch.max_duration))
	end,

	on_flood = on_flood
})

minetest.override_item("default:torch_wall", {

	on_timer = function(pos, elapsed)

		local p2 = minetest.get_node(pos).param2

		minetest.set_node(pos, {name = "real_torch:torch_wall", param2 = p2})

		minetest.sound_play("real_torch_burnout",
				{pos = pos, gain = 0.1, max_hear_distance = 10}, true)
	end,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(
				math.random(real_torch.min_duration, real_torch.max_duration))
	end,

	on_flood = on_flood
})

minetest.override_item("default:torch_ceiling", {

	on_timer = function(pos, elapsed)

		local p2 = minetest.get_node(pos).param2

		minetest.set_node(pos, {name = "real_torch:torch_ceiling", param2 = p2})

		minetest.sound_play("real_torch_burnout",
				{pos = pos, gain = 0.1, max_hear_distance = 10}, true)
	end,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(
				math.random(real_torch.min_duration, real_torch.max_duration))
	end,

	on_flood = on_flood
})
]]--
