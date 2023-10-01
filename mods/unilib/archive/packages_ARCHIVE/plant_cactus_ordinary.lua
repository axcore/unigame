---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Wrapping the functions in ABM action is necessary to make overriding them possible
function default.grow_cactus(pos, node)
	if node.param2 >= 4 then
		return
	end
	pos.y = pos.y - 1
	if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "default:cactus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "default:cactus"})
	return true
end

minetest.register_abm({
	label = "Grow cactus",
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 12,
	chance = 83,
	action = function(...)
		default.grow_cactus(...)
	end
})

function default.grow_large_cactus(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/large_cactus.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end

minetest.register_node("default:cactus", {
	description = S("Cactus"),
	tiles = {"default_cactus_top.png", "default_cactus_top.png",
		"default_cactus_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:cactus",
	burntime = 15,
})

minetest.register_node("default:large_cactus_seedling", {
	description = S("Large Cactus Seedling"),
	drawtype = "plantlike",
	tiles = {"default_large_cactus_seedling.png"},
	inventory_image = "default_large_cactus_seedling.png",
	wield_image = "default_large_cactus_seedling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {
			-5 / 16, -0.5, -5 / 16,
			5 / 16, 0.5, 5 / 16
		}
	},
	groups = {choppy = 3, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_wood_defaults(),

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:large_cactus_seedling",
			{x = -2, y = -1, z = -2},
			{x = 2, y = 5, z = 2},
			4)

		return itemstack
	end,

	on_construct = function(pos)
		-- Normal cactus farming adds 1 cactus node by ABM,
		-- interval 12s, chance 83.
		-- Consider starting with 5 cactus nodes. We make sure that growing a
		-- large cactus is not a faster way to produce new cactus nodes.
		-- Confirmed by experiment, when farming 5 cacti, on average 1 new
		-- cactus node is added on average every
		-- 83 / 5 = 16.6 intervals = 16.6 * 12 = 199.2s.
		-- Large cactus contains on average 14 cactus nodes.
		-- 14 * 199.2 = 2788.8s.
		-- Set random range to average to 2789s.
		minetest.get_node_timer(pos):start(math.random(1859, 3719))
	end,

	on_timer = function(pos)
		local node_under = minetest.get_node_or_nil(
			{x = pos.x, y = pos.y - 1, z = pos.z})
		if not node_under then
			-- Node under not yet loaded, try later
			minetest.get_node_timer(pos):start(300)
			return
		end

		if minetest.get_item_group(node_under.name, "sand") == 0 then
			-- Seedling dies
			minetest.remove_node(pos)
			return
		end

		local light_level = minetest.get_node_light(pos)
		if not light_level or light_level < 13 then
			-- Too dark for growth, try later in case it's night
			minetest.get_node_timer(pos):start(300)
			return
		end

		minetest.log("action", "A large cactus seedling grows into a large" ..
			"cactus at ".. minetest.pos_to_string(pos))
		default.grow_large_cactus(pos)
	end,
})
minetest.register_craft({
	output = "default:large_cactus_seedling",
	recipe = {
		{"", "default:cactus", ""},
		{"default:cactus", "default:cactus", "default:cactus"},
		{"", "default:cactus", ""},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:large_cactus_seedling",
	burntime = 5,
})

minetest.register_decoration({
    name = "default:cactus",
    deco_type = "simple",
    place_on = {"default:desert_sand"},
    sidelen = 16,
    noise_params = {
        offset = -0.0003,
        scale = 0.0009,
        spread = {x = 200, y = 200, z = 200},
        seed = 230,
        octaves = 3,
        persist = 0.6
    },
    biomes = {"desert"},
    y_max = 31000,
    y_min = 4,
    decoration = "default:cactus",
    height = 2,
    height_max = 5,
})

minetest.register_decoration({
    name = "default:large_cactus",
    deco_type = "schematic",
    place_on = {"default:desert_sand"},
    sidelen = 16,
    noise_params = {
        offset = -0.0003,
        scale = 0.0009,
        spread = {x = 200, y = 200, z = 200},
        seed = 230,
        octaves = 3,
        persist = 0.6
    },
    biomes = {"desert"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/large_cactus.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})
]]--
