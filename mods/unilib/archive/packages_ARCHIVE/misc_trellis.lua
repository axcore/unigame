---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:trellis", {
	description = S("Trellis (place on soil before planting grapes)"),
	drawtype = "plantlike",
	tiles = {"farming_trellis.png"},
	inventory_image = "farming_trellis.png",
	visual_scale = 1.9,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "farming:trellis",
	selection_box = farming.select,
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_place = function(itemstack, placer, pointed_thing)

		local pt = pointed_thing

		-- check if pointing at a node
		if not pt or pt.type ~= "node" then
			return
		end

		local under = minetest.get_node(pt.under)

		-- return if any of the nodes are not registered
		if not minetest.registered_nodes[under.name] then
			return
		end

		-- am I right-clicking on something that has a custom on_place set?
		-- thanks to Krock for helping with this issue :)
		local def = minetest.registered_nodes[under.name]
		if def and def.on_rightclick then
			return def.on_rightclick(pt.under, under, placer, itemstack, pt)
		end

		if minetest.is_protected(pt.above, placer:get_player_name()) then
			return
		end

		local nodename = under.name

		if minetest.get_item_group(nodename, "soil") < 2 then
			return
		end

		local top = {
			x = pointed_thing.above.x,
			y = pointed_thing.above.y + 1,
			z = pointed_thing.above.z
		}

		nodename = minetest.get_node(top).name

		if nodename ~= "air" then
			return
		end

		minetest.set_node(pointed_thing.above, {name = "farming:trellis"})

		if not farming.is_creative(placer:get_player_name()) then
			itemstack:take_item()
		end

		return itemstack
	end
})
minetest.register_craft({
	output = "farming:trellis",
	recipe = {
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "default:stick", "default:stick"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:trellis",
	burntime = 15
})
]]--
