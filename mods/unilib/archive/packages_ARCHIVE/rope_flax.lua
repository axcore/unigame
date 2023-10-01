---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("aotearoa:flax_rope", {
	description = "Flax Rope",
	drawtype = "signlike",
	tiles = {"aotearoa_flax_rope.png"},
	inventory_image = "aotearoa_flax_rope.png",
	wield_image = "aotearoa_flax_rope.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {snappy = 3, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = "aotearoa:flax_rope 3",
  recipe = {
    {'aotearoa:flax'},
    {'aotearoa:flax'},
    {'aotearoa:flax'},
  },
})
]]--
