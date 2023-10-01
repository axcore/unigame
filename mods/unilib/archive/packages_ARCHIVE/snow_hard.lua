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
-- Bricks

nodedef = {
	description = "Snow Brick",
	tiles = {"snow_snow_brick.png"},
	is_ground_content = true,
	--freezemelt = "default:water_source", -- deprecated
	liquidtype = "none",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir", -- Allow blocks to be rotated with the screwdriver or
	-- by player position. ~ LazyJ
	 -- I made this a little harder to dig than snow blocks because
	 -- I imagine snow brick as being much more dense and solid than fluffy snow. ~ LazyJ
	groups = {cracky=2, crumbly=2, choppy=2, oddly_breakable_by_hand=2, melts=1,
		icemaker=1, cooks_into_ice=1, cools_lava = 1, snowy = 1},
	 --Let's use the new snow sounds instead of the old grass sounds. ~ LazyJ
	sounds = default.node_sound_snow_defaults(),
	-- The "on_construct" part below, thinking in terms of layers,
	-- dirt_with_snow could also double as dirt_with_frost which adds subtlety
	-- to the winterscape. ~ LazyJ
	on_construct = snow_onto_dirt
}

-- Snow Brick
minetest.register_node("snow:snow_brick", table.copy(nodedef))

minetest.register_craft({
	output = "snow:snow_brick",
	recipe = {
		{"default:snowblock", "default:snowblock"},
		{"default:snowblock", "default:snowblock"}
	}
})

-- Why not recycle snow_bricks back into snowblocks? ~ LazyJ
minetest.register_craft({
	output = "default:snowblock 4",
	recipe = {
		{"snow:snow_brick"}
	}
})

-- Snow Cobble  ~ LazyJ
-- Described as Icy Snow
nodedef.description = "Icy Snow"
nodedef.tiles = {"snow_snow_cobble.png"}

minetest.register_node("snow:snow_cobble", nodedef)

minetest.register_craft({
	type = "shapeless",
	output = "default:snowblock 2",
	recipe = {
		"snow:snow_cobble",
		"snow:snow_cobble"
	}
})

minetest.register_craft({
	output = "snow:snow_cobble 6",
	recipe = {
		{"snow:ice_brick"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "snow:snow_cobble 6",
	recipe = {
		"default:snow",
		"default:snow",
		"default:snow",
		"default:snow",
		"default:snow",
		"default:snow",
		"default:ice",
		"default:ice",
		"default:ice"
	}
})


minetest.register_craft({
	type = "shapeless",
	output = "snow:snow_cobble 4",
	recipe = {
		"default:snow",
		"default:snow",
		"default:snow",
		"default:snow",
		"default:ice",
		"default:ice"
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "snow:snow_cobble 2",
	recipe = {
		"default:snow",
		"default:snow",
		"default:ice"
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "snow:snow_cobble",
	recipe = {
		"default:snow",
		"default:ice"
	}
})
]]--
