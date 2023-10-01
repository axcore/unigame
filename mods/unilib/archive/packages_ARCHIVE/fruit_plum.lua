---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/plumtree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("plumtree:plum", {
	description = S("Plum"),
	drawtype = "plantlike",
	tiles = {"plumtree_plum.png"},
	inventory_image = "plumtree_plum.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "plumtree:plum", param2 = 1})
	end,

	on_dig = function(pos, node, digger)
		if digger:is_player() then
			local inv = digger:get_inventory()
			if inv:room_for_item("main", "plumtree:plum") then
				inv:add_item("main", "plumtree:plum")
			end
		end
		minetest.remove_node(pos)
		pos.y = pos.y + 1
		local node_above = minetest.get_node_or_nil(pos)
		if node_above and node_above.param2 == 0 and node_above.name == "plumtree:blossom_leaves" then
			--20% of variation on time
			local twenty_percent = fruit_grow_time * 0.2
			local grow_time = math.random(fruit_grow_time - twenty_percent, fruit_grow_time + twenty_percent)
			minetest.get_node_timer(pos):start(grow_time)
		end
	end,
})
]]--
