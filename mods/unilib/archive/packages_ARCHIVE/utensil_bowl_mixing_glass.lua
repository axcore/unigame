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
minetest.register_craftitem("farming:mixing_bowl", {
	description = S("Glass Mixing Bowl"),
	inventory_image = "farming_mixing_bowl.png",
	groups = {food_mixing_bowl = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:mixing_bowl",
	recipe = {
		{"default:glass", "group:stick", "default:glass"},
		{"", "default:glass", ""}
	}
})
minetest.register_craft( {
	output = "vessels:glass_fragments",
	recipe = {{"farming:mixing_bowl"}}
})
]]--
