---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriflame
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("abriglass:clear_glass", {
	description = "Clear Glass",
	tiles = {"abriglass_clearglass.png"},
	groups = {cracky = 3},
	use_texture_alpha = "blend",
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike",
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = 'abriglass:clear_glass 4', -- intentional lower yield
	recipe = {
		{'default:glass', '', 'default:glass' },
		{'', 'default:glass', '' },
		{'default:glass', '', 'default:glass' },
	}
})
]]--
