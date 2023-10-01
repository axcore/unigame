---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("chestnuttree:fruit", {
	description = S("Chestnut"),
	inventory_image = "chestnuttree_fruit.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 2, food = 2},
})
minetest.register_craft({
	output = "chestnuttree:fruit",
	recipe = {
		{'chestnuttree:bur'}
	}
})
]]--
