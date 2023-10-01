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
local painting_box = {
	type = "wallmounted",
	wall_top = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
	wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
	wall_side = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375}
}

xdecor.register("painting_1", {
	description = S("Painting"),
	tiles = {"xdecor_painting_1.png"},
	use_texture_alpha = ALPHA_OPAQUE,
	inventory_image = "xdecor_painting_empty.png",
	wield_image = "xdecor_painting_empty.png",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, attached_node = 1},
	sounds = default.node_sound_wood_defaults(),
	node_box = painting_box,
	node_placement_prediction = "",
	on_place = function(itemstack, placer, pointed_thing)
		local num = math.random(4)
		local leftover = minetest.item_place_node(
			ItemStack("xdecor:painting_" .. num), placer, pointed_thing)

		if leftover:get_count() == 0 and
				not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end

		return itemstack
	end
})
minetest.register_craft({
	output = "xdecor:painting_1",
	recipe = {
		{"default:sign_wall_wood", "group:dye"}
	}
})

for i = 2, 4 do
	xdecor.register("painting_" .. i, {
		tiles = {"xdecor_painting_" .. i .. ".png"},
		use_texture_alpha = ALPHA_OPAQUE,
		paramtype2 = "wallmounted",
		drop = "xdecor:painting_1",
		sunlight_propagates = true,
		groups = {
			choppy = 3,
			oddly_breakable_by_hand = 2,
			flammable = 2,
			attached_node = 1,
			not_in_creative_inventory = 1
		},
		sounds = default.node_sound_wood_defaults(),
		node_box = painting_box
	})
end
]]--
