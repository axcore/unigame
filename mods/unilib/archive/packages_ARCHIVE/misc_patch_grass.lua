---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("dryplants:grass", {
	description = S("Cut Grass"),
	inventory_image = "dryplants_grass.png",
	wield_image = "dryplants_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"dryplants_grass.png"},
	drawtype = "nodebox",
	node_box = {
	    type = "fixed",
        fixed = {-0.5   , -0.5   , -0.5   ,   0.5   , -0.4375,  0.5   },
    },
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = "dryplants:grass",
	recipe = {
		{"default:grass_1"},
	}
})
minetest.register_craft({
	output = "dryplants:grass",
	recipe = {
		{"default:junglegrass"},
	}
})

minetest.register_node("dryplants:hay", {
	description = S("Hay"),
	inventory_image = "dryplants_hay.png",
	wield_image = "dryplants_hay.png",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"dryplants_hay.png"},
	drawtype = "nodebox",
	node_box = {
	    type = "fixed",
        fixed = {-0.5   , -0.5   , -0.5   ,   0.5   , -0.4375,  0.5   },
    },
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "dryplants:hay",
	recipe = "dryplants:grass",
	cooktime = 2,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dryplants:hay",
	burntime = 1,
})

minetest.register_abm({
	nodenames = {"dryplants:grass"},
	interval = HAY_DRYING_TIME, --1200, -- 20 minutes: a minetest-day/night-cycle
	chance = 1,
	action = function(pos)
		minetest.swap_node(pos, {name="dryplants:hay"})
	end,
})
]]--
