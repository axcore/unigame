---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xpanes.register_pane("wood", {
	description = S("Wooden Bars"),
	inventory_image = "mtg_plus_wooden_bar.png",
	wield_image = "mtg_plus_wooden_bar.png",
	textures = {"mtg_plus_wooden_bar.png", "mtg_plus_wooden_bar_side.png", "mtg_plus_wooden_bar_y.png"},
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=2, pane=1},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{ "group:wood", "", "group:wood" },
		{ "group:wood", "", "group:wood" },
		{ "group:wood", "", "group:wood" },
	}
})

if minetest.registered_items["xpanes:wood_flat"] then
	r = "xpanes:wood_flat"
else
	r = "xpanes:wood"
end
minetest.register_craft({
	type = "fuel",
	recipe = r,
	burntime = 2,
})
]]--
