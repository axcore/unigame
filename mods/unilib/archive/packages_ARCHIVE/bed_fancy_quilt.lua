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
local fancy_texture = "beds_bed_fancy_inv.png^wool_"..color..".png^beds_bed_fancy_inv.png^[makealpha:255,128,128"

beds.register_bed("beds:fancy_bed_" ..color, {
	description = "Fancy " ..desc.." Bed" ,
	inventory_image = fancy_texture,
	wield_image = fancy_texture,
	tiles = {
		bottom = {
			"beds_bed_top1_"..color..".png",
			"default_wood.png",
			"beds_bed_side1_"..color..".png",
			"beds_bed_side1_"..color..".png^[transformfx",
			"beds_bed_foot_"..color..".png"
		},
		top = {
			"beds_bed_top2_"..color..".png",
			"default_wood.png",
			"beds_bed_side2_"..color..".png",
			"beds_bed_side2_"..color..".png^[transformfx",
			"beds_bed_head.png",
		}
	},
	nodebox = {
		bottom = {
			{-0.5, -0.5, -0.5, -0.375, 0.125, -0.375},
			{0.375, -0.5, -0.5, 0.5, 0.125, -0.375},
			{-0.375, -0.0625, -0.46875, 0.375, 0.0625, -0.40625},
			{-0.4375, -0.375, -0.46875, 0.4375, -0.125, 0.5},
			{-0.375, -0.125, -0.375, 0.375, -0.0625, 0.5},
		},
		top = {
			{0.375, -0.5, 0.375, 0.5, 0.1875, 0.5},
			{-0.5, -0.5, 0.375, -0.375, 0.1875, 0.5},
			{-0.375, -0.0625, 0.40625, 0.375, 0.125, 0.46875},
			{-0.4375, -0.375, -0.5, 0.4375, -0.125, 0.46875},
			{-0.375, -0.125, -0.5, 0.375, -0.0625, 0.375},
		}
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.1875, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"wool:"..color, "wool:"..color, "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})
]]--
