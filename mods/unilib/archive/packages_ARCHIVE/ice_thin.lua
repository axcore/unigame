---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("caverealms:thin_ice", {
	description = "Thin Ice",
	tiles = {"caverealms_thin_ice.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
	freezemelt = "default:water_source",
	paramtype = "light",
})
minetest.register_craft({
	output = "default:water_source",
	type = "shapeless",
	recipe = {"caverealms:thin_ice"}
})
]]--
