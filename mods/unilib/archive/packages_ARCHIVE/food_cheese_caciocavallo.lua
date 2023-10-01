---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cheese:caciocavallo", {
	description = S("Caciocavallo"),
	inventory_image = "caciocavallo.png",
	wield_image = "caciocavallo.png",
	tiles = {
		"caciocavallo_top.png",
		"caciocavallo_bottom.png",
		"caciocavallo_right.png",
		"caciocavallo_left.png",
		"caciocavallo_back.png",
		"caciocavallo_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {food = 8, food_cheese = 1, oddly_breakable_by_hand = 3},
	on_use = minetest.item_eat(8),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.0625, 0.1875, 0.125, 0.125}, -- body
			{-0.0625, 0.0625, -0.0625, 0.125, 0.1875, 0.125}, -- neck
			{-0.125, 0.1875, -0.0625, 0.0625, 0.3125, 0.125}, -- head
			{0, 0.1875, 0, 0.125, 0.5, 0.0625}, -- strip
			{-0.1875, -0.25, -0.0625, 0.25, 0.0625, 0.125}, -- body2
			{-0.125, -0.25, -0.125, 0.1875, 0.0625, 0.1875}, -- body3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875}, -- selection
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875}, -- selection
		}
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if placer:is_player() and itemstack:is_empty() == false then
			local above_name = minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name

			if minetest.get_item_group( above_name , "wood" ) == 0 then
				minetest.set_node(pos, {name = "air"})
				minetest.add_item(pos, "cheese:fresh_caciocavallo")
			end
		end
	end,
})

local strip = "farming:string" -- the string is also present in a "vanilla" mt game, just not the redo. i can skip the leather strip

minetest.register_node("cheese:fresh_caciocavallo", {
	description = S("Fresh Caciocavallo"),
	inventory_image = "fresh_caciocavallo.png",
	wield_image = "fresh_caciocavallo.png",
	tiles = {
		"fresh_caciocavallo_top.png",
		"fresh_caciocavallo_bottom.png",
		"fresh_caciocavallo_right.png",
		"fresh_caciocavallo_left.png",
		"fresh_caciocavallo_back.png",
		"fresh_caciocavallo_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.0625, 0.1875, 0.125, 0.125}, -- body
			{-0.0625, 0.0625, -0.0625, 0.125, 0.1875, 0.125}, -- neck
			{-0.125, 0.1875, -0.0625, 0.0625, 0.3125, 0.125}, -- head
			{0, 0.1875, 0, 0.125, 0.5, 0.0625}, -- strip
			{-0.1875, -0.25, -0.0625, 0.25, 0.0625, 0.125}, -- body2
			{-0.125, -0.25, -0.125, 0.1875, 0.0625, 0.1875}, -- body3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875}, -- selection
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875}, -- selection
		}
	},
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start( 70 + math.random(-5.0 , 5.0) )

	end,
  after_place_node = function(pos, placer, itemstack, pointed_thing)
		if placer:is_player() and itemstack:is_empty() == false then
			local above_name = minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name
			--minetest.chat_send_player("singleplayer", "Node ".. minetest.get_node(pos).name .. " and Above "..above_name.."Light at Node is ".. minetest.get_node_light(pos))

			if above_name ~= "ignore" and minetest.get_item_group( above_name , "wood" ) == 0 then
				minetest.set_node(pos, {name = "air"})
				minetest.add_item(pos, "cheese:fresh_caciocavallo")
			end
		end
	end,
	on_timer = function(pos)
		local timer = minetest.get_node_timer(pos)
		local above_name = minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name -- fakes a reverse group:attached behaviour
		if above_name ~= "ignore" and minetest.get_item_group( above_name , "wood" ) > 0 then
			if minetest.get_node_light(pos) <= 7 and minetest.get_node_light(pos) >= 12 or math.random() > 0.1 then
				return true
			end
		else
			timer:stop()
			minetest.set_node(pos, {name = "air"})
			minetest.add_item(pos, "cheese:fresh_caciocavallo")
			return false
		end
		local node = minetest.get_node(pos)
		if node.name ~= "ignore" then
			minetest.set_node(pos, {name = "cheese:caciocavallo", param2= node.param2})
			return false
		end
		return true
	end,
})
minetest.register_craft({
	output = "cheese:fresh_caciocavallo 4",
	recipe = {
		{"", strip, "cheese:stretched_cheese"},
		{"cheese:stretched_cheese", "cheese:stretched_cheese", strip},
		{"cheese:stretched_cheese", "cheese:stretched_cheese", ""},
	}
})
]]--
