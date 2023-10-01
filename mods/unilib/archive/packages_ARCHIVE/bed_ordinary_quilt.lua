---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    colored_beds
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local simple_texture = "beds_bed_inv.png^wool_"..color..".png^beds_bed_inv.png^[makealpha:255,128,128"

beds.register_bed("beds:bed_" ..color, {
	description =  desc.. " Bed",
	inventory_image = simple_texture,
	wield_image = simple_texture,
	tiles = {
		bottom = {
			"wool_"..color..".png",
			"default_wood.png",
			"beds_bed_side_bottom_r_"..color..".png",
			"beds_bed_side_bottom_r_"..color..".png^[transformfx",
			"beds_bed_side_bottom_"..color..".png"
		},
		top = {
			"beds_bed_top_top_"..color..".png",
			"default_wood.png",
			"beds_bed_side_top_r_"..color..".png",
			"beds_bed_side_top_r_"..color..".png^[transformfx",
			"beds_bed_side_top.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:"..color, "wool:"..color, "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})
]]--
