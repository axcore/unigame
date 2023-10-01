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
minetest.register_node("caverealms:glow_crystal", {
	description = "Glow Crystal",
	tiles = {"caverealms_glow_crystal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

minetest.register_node("caverealms:glow_ore", {
	description = "Glow Crystal Ore",
	tiles = {"caverealms_glow_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 10,
	paramtype = "light",
})
]]--
