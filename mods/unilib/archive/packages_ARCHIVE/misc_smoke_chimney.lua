---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bbq:chimney_smoke", {
	description = ("Chimney Smoke"),
	inventory_image = "bbq_chimney_smoke.png",
	wield_image = "bbq_chimney_smoke.png",
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	tiles = {
		{
			image = "bbq_chimney_smoke_animation.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		},

	},


	groups = {dig_immediate = 3, attached_node = 1},
})
minetest.register_craft({
	output = "bbq:chimney_smoke",
	recipe = {
		{"", "group:wood", ""},
		{"", "group:wood", ""},
		{"", "default:torch", ""}
	}
})
]]--
