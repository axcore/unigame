---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xdecor.register("trampoline", {
	description = S("Trampoline"),
	tiles = {"xdecor_trampoline.png", "mailbox_blank16.png", "xdecor_trampoline_sides.png"},
	use_texture_alpha = ALPHA_CLIP,
	groups = {cracky = 3, oddly_breakable_by_hand = 1, fall_damage_add_percent = -80, bouncy = 90},
	node_box = xdecor.nodebox.slab_y(0.5),
	sounds = {
		footstep = {
			name = "xdecor_bouncy",
			gain = 0.8
		}
	}
})
minetest.register_craft({
	output = "xdecor:trampoline",
	recipe = {
		{"farming:string", "farming:string", "farming:string"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})
]]--
