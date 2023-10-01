---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function mapgen.register_fern(name, desc, texnumber)
minetest.register_node("mapgen:"..name, {
	description = desc,
	drawtype = "mesh",
	mesh = "fern.b3d",
	tiles = {
		"mapgen_fern"..texnumber..".png",
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	paramtype2 = "degrotate",
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, oddly_breakable_by_hand = 1, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults()
})
end

mapgen.register_fern("fern2", "Broad Leaf Fern", "2")

minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_junglegrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"rainforest",},
	decoration = "mapgen:fern2",
	height = 1,
})
]]--
