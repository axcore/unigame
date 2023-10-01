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
function mapgen.register_shrub(name, desc, texnumber)
minetest.register_node("mapgen:"..name, {
	description = desc,
	drawtype = "mesh",
	mesh = "shrub.obj",
	tiles = {
		"mapgen_shrub"..texnumber..".png",
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	on_construct = function(pos, node)
		local node = minetest.get_node(pos)
		node.param2 = math.random(0,179)
	end,
	paramtype2 = "degrotate",
	visual_scale = 0.5,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, oddly_breakable_by_hand = 1, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults()
})
end

mapgen.register_shrub("shrub", "Hog Peanut", "1")

minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_leafygrass",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"coniferous_forest_tall",},
	decoration = "mapgen:shrub",
	height = 1,
})
]]--
