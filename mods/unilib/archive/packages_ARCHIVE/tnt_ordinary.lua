---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tnt
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("tnt:boom", {
	drawtype = "airlike",
	inventory_image = "tnt_boom.png",
	wield_image = "tnt_boom.png",
	light_source = default.LIGHT_MAX,
	walkable = false,
	drop = "",
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	-- unaffected by explosions
	on_blast = function() end,
})

minetest.register_node("tnt:gunpowder", {
	description = S("Gun Powder"),
	drawtype = "raillike",
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	tiles = {
		"tnt_gunpowder_straight.png",
		"tnt_gunpowder_curved.png",
		"tnt_gunpowder_t_junction.png",
		"tnt_gunpowder_crossing.png"
	},
	inventory_image = "tnt_gunpowder_inventory.png",
	wield_image = "tnt_gunpowder_inventory.png",
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate = 2, attached_node = 1, flammable = 5,
		connect_to_raillike = minetest.raillike_group("gunpowder")},
	sounds = default.node_sound_leaves_defaults(),

	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:torch" then
			minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
			minetest.log("action", puncher:get_player_name() ..
				" ignites tnt:gunpowder at " ..
				minetest.pos_to_string(pos))
		end
	end,
	on_blast = function(pos, intensity)
		minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
	end,
	on_burn = function(pos)
		minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
	end,
	on_ignite = function(pos, igniter)
		minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
	end,
})
minetest.register_craft({
	output = "tnt:gunpowder 5",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:gravel"}
})

minetest.register_node("tnt:gunpowder_burning", {
	drawtype = "raillike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	tiles = {{
		name = "tnt_gunpowder_burning_straight_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	},
	{
		name = "tnt_gunpowder_burning_curved_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	},
	{
		name = "tnt_gunpowder_burning_t_junction_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	},
	{
		name = "tnt_gunpowder_burning_crossing_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	}},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	drop = "",
	groups = {
		dig_immediate = 2,
		attached_node = 1,
		connect_to_raillike = minetest.raillike_group("gunpowder"),
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	on_timer = function(pos, elapsed)
		for dx = -1, 1 do
		for dz = -1, 1 do
			if math.abs(dx) + math.abs(dz) == 1 then
				for dy = -1, 1 do
					tnt.burn({
						x = pos.x + dx,
						y = pos.y + dy,
						z = pos.z + dz,
					})
				end
			end
		end
		end
		minetest.remove_node(pos)
	end,
	-- unaffected by explosions
	on_blast = function() end,
	on_construct = function(pos)
		minetest.sound_play("tnt_gunpowder_burning", {pos = pos,
			gain = 2}, true)
		minetest.get_node_timer(pos):start(1)
	end,
})

minetest.register_craftitem("tnt:tnt_stick", {
	description = S("TNT Stick"),
	inventory_image = "tnt_tnt_stick.png",
	groups = {flammable = 5},
})

if enable_tnt then
	minetest.register_craft({
		output = "tnt:tnt_stick 2",
		recipe = {
			{"tnt:gunpowder", "", "tnt:gunpowder"},
			{"tnt:gunpowder", "default:paper", "tnt:gunpowder"},
			{"tnt:gunpowder", "", "tnt:gunpowder"},
		}
	})

	minetest.register_craft({
		output = "tnt:tnt",
		recipe = {
			{"tnt:tnt_stick", "tnt:tnt_stick", "tnt:tnt_stick"},
			{"tnt:tnt_stick", "tnt:tnt_stick", "tnt:tnt_stick"},
			{"tnt:tnt_stick", "tnt:tnt_stick", "tnt:tnt_stick"}
		}
	})

	minetest.register_abm({
		label = "TNT ignition",
		nodenames = {"group:tnt", "tnt:gunpowder"},
		neighbors = {"fire:basic_flame", "default:lava_source", "default:lava_flowing"},
		interval = 4,
		chance = 1,
		action = function(pos, node)
			tnt.burn(pos, node.name)
		end,
	})
end
]]--
