---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("youngtrees:bamboo", {
	description = S("Young Bamboo Tree"),
	drawtype="nodebox",
	tiles = {"bamboo.png"},
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	node_box = {
	type = "fixed",
	fixed = {
		{-0.058251,-0.500000,-0.413681,0.066749,0.500000,-0.282500}, --NodeBox 1
		{-0.058251,-0.500000,-0.103123,0.066749,0.500000,0.038672}, --NodeBox 2
		{-0.058251,-0.500000,0.181227,0.066749,0.500000,0.342500}, --NodeBox 3
		}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})
]]--
