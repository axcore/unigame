---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("fireflies:firefly", {
	description = S("Firefly"),
	drawtype = "plantlike",
	tiles = {{
		name = "fireflies_firefly_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.5
		},
	}},
	inventory_image = "fireflies_firefly.png",
	wield_image =  "fireflies_firefly.png",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	buildable_to = true,
	walkable = false,
	groups = {catchable = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	},
	light_source = 6,
	floodable = true,
	on_place = function(itemstack, placer, pointed_thing)
		local player_name = placer:get_player_name()
		local pos = pointed_thing.above

		if not minetest.is_protected(pos, player_name) and
				not minetest.is_protected(pointed_thing.under, player_name) and
				minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name = "fireflies:firefly"})
			minetest.get_node_timer(pos):start(1)
			itemstack:take_item()
		end
		return itemstack
	end,
	on_timer = function(pos, elapsed)
		if minetest.get_node_light(pos) > 11 then
			minetest.set_node(pos, {name = "fireflies:hidden_firefly"})
		end
		minetest.get_node_timer(pos):start(30)
	end
})

minetest.register_node("fireflies:hidden_firefly", {
	description = S("Hidden Firefly"),
	drawtype = "airlike",
	inventory_image = "fireflies_firefly.png^default_invisible_node_overlay.png",
	wield_image =  "fireflies_firefly.png^default_invisible_node_overlay.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	floodable = true,
	on_place = function(itemstack, placer, pointed_thing)
		local player_name = placer:get_player_name()
		local pos = pointed_thing.above

		if not minetest.is_protected(pos, player_name) and
				not minetest.is_protected(pointed_thing.under, player_name) and
				minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name = "fireflies:hidden_firefly"})
			minetest.get_node_timer(pos):start(1)
			itemstack:take_item()
		end
		return itemstack
	end,
	on_timer = function(pos, elapsed)
		if minetest.get_node_light(pos) <= 11 then
			minetest.set_node(pos, {name = "fireflies:firefly"})
		end
		minetest.get_node_timer(pos):start(30)
	end
})

minetest.register_decoration({
    name = "fireflies:firefly_low",
    deco_type = "simple",
    place_on = {
        "default:dirt_with_grass",
        "default:dirt_with_coniferous_litter",
        "default:dirt_with_rainforest_litter",
        "default:dirt"
    },
    place_offset_y = 2,
    sidelen = 80,
    fill_ratio = 0.0005,
    biomes = {
        "deciduous_forest",
        "coniferous_forest",
        "rainforest",
        "rainforest_swamp"
    },
    y_max = 31000,
    y_min = -1,
    decoration = "fireflies:hidden_firefly",
})

minetest.register_decoration({
    name = "fireflies:firefly_high",
    deco_type = "simple",
    place_on = {
        "default:dirt_with_grass",
        "default:dirt_with_coniferous_litter",
        "default:dirt_with_rainforest_litter",
        "default:dirt"
    },
    place_offset_y = 3,
    sidelen = 80,
    fill_ratio = 0.0005,
    biomes = {
        "deciduous_forest",
        "coniferous_forest",
        "rainforest",
        "rainforest_swamp"
    },
    y_max = 31000,
    y_min = -1,
    decoration = "fireflies:hidden_firefly",
})
]]--
