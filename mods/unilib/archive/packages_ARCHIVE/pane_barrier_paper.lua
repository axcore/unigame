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
xpanes.register_pane("paper", {
	description = S("Paper Barrier"),
	inventory_image = "mtg_plus_paperwall.png",
	wield_image = "mtg_plus_paperwall.png",
	textures = {"mtg_plus_paperwall.png", "mtg_plus_paperwall.png", "mtg_plus_paperwall.png"},
	groups = {snappy=3, flammable=4, pane=1},
	sounds = {
		footstep = {name="mtg_plus_paper_step", gain=0.1, max_hear_distance=7},
		place = {name="mtg_plus_paper_step", gain=0.3, max_hear_distance=13},
		dig = {name="mtg_plus_paper_dig", gain=0.1, max_hear_distance=11},
		dug = {name="mtg_plus_paper_dug", gain=0.2, max_hear_distance=13},
	},
	recipe = {
		{ "default:paper", "default:paper", "default:paper" },
		{ "default:paper", "default:paper", "default:paper" },
	}
})

local r
if minetest.registered_items["xpanes:paper_flat"] then
	r = "xpanes:paper_flat"
else
	r = "xpanes:paper"
end
minetest.register_craft({
	type = "fuel",
	recipe = r,
	burntime = 1,
})
]]--
