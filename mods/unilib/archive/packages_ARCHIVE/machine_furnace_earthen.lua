---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("earthbuild:earthen_furnace", {
	description = "Earthen Furnace",
	tiles = {
		"earthbuild_furnace_top.png", "earthbuild_furnace_side.png",
		"earthbuild_furnace_side.png", "earthbuild_furnace_side.png",
		"earthbuild_furnace_side.png", "earthbuild_furnace_front.png"
	},
	paramtype2 = "facedir",
	groups = {crumbly = 2, cracky = 3},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_timer = furnace_node_timer,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", inactive_formspec)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('fuel', 1)
		inv:set_size('dst', 4)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether furnace can burn or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "src", drops)
		default.get_inventory_drops(pos, "fuel", drops)
		default.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "earthbuild:earthen_furnace"
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})
minetest.register_craft({
	output = 'earthbuild:earthen_furnace',
	recipe = {
		{'earthbuild:cob', 'earthbuild:cob', 'earthbuild:cob'},
		{'earthbuild:cob', '', 'earthbuild:cob'},
		{'earthbuild:cob', 'earthbuild:hearth', 'earthbuild:cob'},
	}
})
minetest.register_craft({
	output = 'earthbuild:earthen_furnace',
	recipe = {
		{'earthbuild:mud_brick', 'earthbuild:mud_brick', 'earthbuild:mud_brick'},
		{'earthbuild:mud_brick', '', 'earthbuild:mud_brick'},
		{'earthbuild:mud_brick', 'earthbuild:hearth', 'earthbuild:mud_brick'},
	}
})
minetest.register_craft({
	output = 'earthbuild:earthen_furnace',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:rammed_earth', 'earthbuild:rammed_earth'},
		{'earthbuild:rammed_earth', '', 'earthbuild:rammed_earth'},
		{'earthbuild:rammed_earth', 'earthbuild:hearth', 'earthbuild:rammed_earth'},
	}
})

minetest.register_node("earthbuild:earthen_furnace_active", {
	description = "Earthen Furnace",
	tiles = {
		{
			image = "earthbuild_furnace_top_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		},
		"earthbuild_furnace_side.png",
		"earthbuild_furnace_side.png", "earthbuild_furnace_side.png",
		"earthbuild_furnace_side.png",
		{
			image = "earthbuild_furnace_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "earthbuild:earthen_furnace",
	groups = {crumbly = 2, cracky = 3, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_timer = furnace_node_timer,

	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})
]]--
