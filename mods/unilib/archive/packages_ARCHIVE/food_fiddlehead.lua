---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("ferns:fiddlehead", {
	description = S("Fiddlehead"),
	inventory_image = "ferns_fiddlehead.png",
	on_use = minetest.item_eat(-1), -- slightly poisonous when raw
})
minetest.register_craft({
	type = "shapeless",
	output = "ferns:fiddlehead 3",
	recipe = {"ferns:fern_01"},
	replacements = {
		{fern1, "ferns:ferntuber"}
	},
})
minetest.register_craft({
	type = "shapeless",
	output = "ferns:fiddlehead 3",
	recipe = {"ferns:tree_fern_leaves"},
	replacements = {
		{"ferns:tree_fern_leaves", "ferns:sapling_tree_fern"}
	},
})

minetest.register_craftitem("ferns:fiddlehead_roasted", {
	description = S("Roasted Fiddlehead"),
	inventory_image = "ferns_fiddlehead_roasted.png",
	on_use = minetest.item_eat(1), -- edible when cooked
})
minetest.register_craft({
	type = "cooking",
	output = "ferns:fiddlehead_roasted",
	recipe = "ferns:fiddlehead",
	cooktime = 1,
})
]]--
