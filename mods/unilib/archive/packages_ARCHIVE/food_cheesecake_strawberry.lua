---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
pie.register_pie("scsk", "Strawberry Cheesecake")
minetest.register_craft({
	output = "pie:scsk_0",
	recipe = {
		{i_strawberry, i_milk, i_strawberry},
		{i_sugar, i_egg, i_sugar},
		{i_wheat, i_flour, i_wheat}
	},
	replacements = replace_these
})
]]--
