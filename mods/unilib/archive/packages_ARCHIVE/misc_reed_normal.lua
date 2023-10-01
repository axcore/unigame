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
minetest.register_node("dryplants:reed", {
	description = S("Reed"),
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({ -- hay -> reed
	output = "dryplants:reed 2",
	recipe = {
		{"dryplants:hay","dryplants:hay"},
		{"dryplants:hay","dryplants:hay"},
	}
})
minetest.register_craft({ -- wetreed -> reed
	type = "cooking",
	output = "dryplants:reed",
	recipe = "dryplants:wetreed",
	cooktime = 2,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dryplants:reed",
	burntime = 4,
})

minetest.register_node("dryplants:wetreed", {
	description = S("Wet Reed"),
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed_wet.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({ -- papyrus -> wetreed
	output = "dryplants:wetreed 2",
	recipe = {
		{"default:papyrus","default:papyrus"},
		{"default:papyrus","default:papyrus"},
	}
})
minetest.register_craft({ -- reedmace_sapling -> wetreed
	output = "dryplants:wetreed 2",
	recipe = {
		{"dryplants:reedmace_sapling","dryplants:reedmace_sapling"},
		{"dryplants:reedmace_sapling","dryplants:reedmace_sapling"},
	}
})
minetest.register_craft({ -- reedmace_top -> wetreed
	output = "dryplants:wetreed 2",
	recipe = {
		{"dryplants:reedmace_top","dryplants:reedmace_top"},
		{"dryplants:reedmace_top","dryplants:reedmace_top"},
	}
})
minetest.register_craft({ -- reedmace -> wetreed
	output = "dryplants:wetreed 2",
	recipe = {
		{"dryplants:reedmace","dryplants:reedmace"},
		{"dryplants:reedmace","dryplants:reedmace"},
	}
})
minetest.register_craft({ -- reedmace_bottom -> wetreed
	output = "dryplants:wetreed 2",
	recipe = {
		{"dryplants:reedmace_bottom","dryplants:reedmace_bottom"},
		{"dryplants:reedmace_bottom","dryplants:reedmace_bottom"},
	}
})
]]--
