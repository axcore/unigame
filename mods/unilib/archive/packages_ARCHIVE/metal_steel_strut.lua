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
local base_tex = "steel_strut.png"

if minetest.get_modpath("streets") or minetest.get_modpath("steelsupport") then
	minetest.register_alias("steel:strut", "streets:steel_support")
	base_tex = "streets_support.png"
else
	minetest.register_node("steel:strut", {
		drawtype = "glasslike",
		description = "Strut",
		tiles = {base_tex},
		use_texture_alpha = "clip",
		paramtype = "light",
		sounds =  sound_api.node_sound_stone_defaults(),
		groups = {choppy = 1, cracky = 1, dig_stone = 1},
	})
	minetest.register_alias("streets:steel_support", "steel:strut")
end
	minetest.register_craft({
		output = "steel:strut 5",
		recipe = {
			{"", steel_item, ""},
			{steel_item, steel_item, steel_item},
			{"", steel_item, ""},
		}
	})
minetest.register_craft({
	output = "steel:scrap 2",
	recipe = {{"steel:strut"}}
})

minetest.register_node("steel:strut_mount", {
	description = "Strut with mount",
	drawtype = "mesh",
	mesh = "steel_cube.obj",
	tiles = {
		base_tex,
		base_tex,
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {choppy = 1, cracky = 1, dig_stone = 1},
})
	minetest.register_craft({
		output = "steel:strut_mount",
		recipe = {{"steel:strut", steel_item}}
	})
]]--
