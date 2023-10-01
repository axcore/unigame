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
minetest.register_node("mtg_plus:graveldirt", {
	description = S("Gravel Dirt"),
	_doc_items_longdesc = S("Gravel dirt is a type of dirt consisting of equal parts of gravel and dirt. It combines some of the properties of gravel and dirt."),
	tiles = {"mtg_plus_graveldirt.png"},
	is_ground_content = true,
	groups = { crumbly = 2, level = 1, soil = 1, },
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		items = {
			{ items = { "default:gravel" } },
			{ items = { "default:dirt" } },
		}
	},
})
minetest.register_craft({
	type = "shapeless",
	output = "mtg_plus:graveldirt",
	recipe = { "default:gravel", "default:dirt" },
})
]]--
