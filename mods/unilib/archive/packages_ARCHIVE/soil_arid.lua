---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:dry_soil", {
	description = S("Savanna Soil"),
	tiles = {"default_dry_dirt.png^farming_soil.png", "default_dry_dirt.png"},
	drop = "default:dry_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "default:dry_dirt",
		dry = "farming:dry_soil",
		wet = "farming:dry_soil_wet"
	}
})

minetest.register_node("farming:dry_soil_wet", {
	description = S("Wet Savanna Soil"),
	tiles = {"default_dry_dirt.png^farming_soil_wet.png", "default_dry_dirt.png^farming_soil_wet_side.png"},
	drop = "default:dry_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "default:dry_dirt",
		dry = "farming:dry_soil",
		wet = "farming:dry_soil_wet"
	}
})
]]--
