---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("forest:oil_source", {
	description = "Oil source",
	inventory_image = minetest.inventorycube("oil.png"),
	drawtype = "liquid",
	tiles = {
		{name="oil_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=22}}
	},
	special_tiles = {
		{
			name="oil_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=22},
			backface_culling = false,
		}
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "forest:oil_flowing",
	liquid_alternative_source = "forest:oil_source",
	liquid_viscosity = 4,
	damage_per_second = 1,
	post_effect_color = {a=255, r=32, g=20, b=12},
	groups = {liquid=3, flammable=2, oil=1},
})

minetest.register_node("forest:oil_flowing", {
	description = "Oil flowing",
	inventory_image = minetest.inventorycube("oil.png"),
	drawtype = "flowingliquid",
	tiles = {"oil.png"},
	special_tiles = {
		{
			image="oil_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=10}
		},
		{
			image="oil_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=10}
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "forest:oil_flowing",
	liquid_alternative_source = "forest:oil_source",
	liquid_viscosity = 4,
	damage_per_second = 1,
	post_effect_color = {a=255, r=32, g=20, b=12},
	groups = {liquid=3, flammable=2, not_in_creative_inventory=1, oil=1},
})
]]--
