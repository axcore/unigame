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
minetest.register_craftitem("farming:mint_tea", {
	description = S("Mint Tea"),
	inventory_image = "farming_mint_tea.png",
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {flammable = 4}
})
minetest.register_craft({
	output = "farming:mint_tea",
	recipe = {
		{"group:food_mint", "group:food_mint", "group:food_mint"},
		{"group:water_bucket", "farming:juicer", "vessels:drinking_glass"}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"},
		{"group:water_bucket", "bucket:bucket_empty"}
	}
})
if minetest.get_modpath("bucket_wooden") then
	minetest.register_craft({
		output = "farming:mint_tea",
		recipe = {
			{"group:food_mint", "group:food_mint", "group:food_mint"},
			{"group:water_bucket_wooden", "farming:juicer", "vessels:drinking_glass"}
		},
		replacements = {
			{"group:food_juicer", "farming:juicer"},
			{"group:water_bucket_wooden", "bucket_wooden:bucket_empty"}
		}
	})
end
]]--
