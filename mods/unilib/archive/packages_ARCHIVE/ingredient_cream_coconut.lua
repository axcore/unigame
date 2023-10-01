---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if cheese.moretrees then
	minetest.register_craftitem("cheese:coconut_cream", {
		description = S("Coconut Cream"),
		inventory_image = "coconut_cream.png",
		groups = {food_cream = 1, vegan_alternative = 1, food_vegan = 1},
	})
	minetest.override_item("moretrees:coconut_milk",{
		groups = {vessel = 1, food_coconut_milk = 1},
	})

	table.insert(creamable, {"moretrees:coconut_milk",	"cheese:coconut_cream 2"})
end
]]--
