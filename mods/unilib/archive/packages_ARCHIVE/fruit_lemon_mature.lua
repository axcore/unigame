---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/lemontree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lemontree:lemon", {
	description = S("Lemon"),
	drawtype = "plantlike",
	tiles = {"lemontree_lemon.png"},
	inventory_image = "lemontree_lemon.png",
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
		minetest.set_node(pos, {name = "lemontree:lemon", param2 = 1})
	end,

	on_dig = function(pos, node, digger)
		if digger:is_player() then
			local inv = digger:get_inventory()
			if inv:room_for_item("main", "lemontree:lemon") then
				inv:add_item("main", "lemontree:lemon")
			end
		end
		minetest.remove_node(pos)
		pos.y = pos.y + 1
		local node_above = minetest.get_node_or_nil(pos)
		if node_above and node_above.param2 == 0 and node_above.name == "lemontree:leaves" then
			local timer = minetest.get_node_timer(pos)
			timer:start(fruit_grow_time)
		end
	end,
})
]]--
