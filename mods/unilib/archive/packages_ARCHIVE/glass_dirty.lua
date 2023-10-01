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
minetest.register_node("mtg_plus:dirty_glass", {
	description = S("Dirty Glass"),
	_doc_items_longdesc = S("A decorative, semitransparent block. The dirt makes it hard for the sunlight to pass through."),
	drawtype = "glasslike_framed_optional",
	tiles = {"mtg_plus_dirty_glass.png", "mtg_plus_dirty_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = false,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:dirty_glass 3",
	recipe = { { "", "default:dirt", "" },
		{"default:glass", "default:glass", "default:glass"},
	}
})

if minetest.get_modpath("moreblocks") then
	minetest.register_craft({
		type = "shapeless",
		output = "default:glass",
		recipe = {"mtg_plus:dirty_glass", "moreblocks:sweeper"}
	})
	minetest.register_craft({
		type = "shapeless",
		output = "moreblocks:clean_glass",
		recipe = {"mtg_plus:dirty_glass", "moreblocks:sweeper", "moreblocks:sweeper"}
	})
	minetest.register_craft({
		output = "mtg_plus:dirty_glass",
		recipe = {
			{"default:dirt"},
			{"moreblocks:clean_glass"}
		}
	})
end
]]--
