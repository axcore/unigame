---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:carrot_gold", {
	description = S("Golden Carrot"),
	inventory_image = "farming_carrot_gold.png",
	on_use = minetest.item_eat(10)
})
minetest.register_craft({
	output = "farming:carrot_gold",
	recipe = {
		{"", "default:gold_lump", ""},
		{"default:gold_lump", "group:food_carrot", "default:gold_lump"},
		{"", "default:gold_lump", ""}
	}
})
]]--
