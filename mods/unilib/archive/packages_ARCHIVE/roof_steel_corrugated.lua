---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("steel:roofing", {
	description = "Corrugated steel roofing",
	drawtype = "raillike",
	tiles = {"steel_corrugated_steel.png"},
	inventory_image = "steel_corrugated_steel.png",
	wield_image = "steel_corrugated_steel.png",
	paramtype = "light",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, dig_generic = 1},
})
	minetest.register_craft({
		output = "steel:roofing 6",
		recipe = {{steel_item, steel_item, steel_item}}
	})
minetest.register_craft({
	output = "steel:scrap",
	recipe = {{"steel:roofing"}}
})
]]--
