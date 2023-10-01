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
minetest.register_craftitem("farming:onion_soup", {
	description = S("Onion Soup"),
	inventory_image = "farming_onion_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(6, "farming:bowl")
})
minetest.register_craft({
	output = "farming:onion_soup",
	recipe = {
		{"group:food_onion", "group:food_onion", "group:food_onion"},
		{"group:food_onion", "group:food_pot", "group:food_onion"},
		{"", "group:food_bowl", ""}
	},
	replacements = {{"farming:pot", "farming:pot"}}
})
]]--
