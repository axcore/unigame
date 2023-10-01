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
minetest.register_node("caverealms:salt_crystal", {
	description = "Salt Crystal",
	tiles = {"caverealms_salt_crystal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 11,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

minetest.register_node("caverealms:stone_with_salt", {
	description = "Cave Stone with Salt",
	tiles = {"caverealms_salty2.png"},--{"caverealms_salty2.png^caverealms_salty.png", "caverealms_salty2.png", "caverealms_salty2.png^caverealms_salty_side.png"},
	light_source = 9,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_glass_defaults(),
})
]]--
