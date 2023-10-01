---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("ethereal:firethorn_jelly", {
	description = S("Firethorn Jelly"),
	inventory_image = "ethereal_firethorn_jelly.png",
	wield_image = "ethereal_firethorn_jelly.png",
	on_use = minetest.item_eat(2, "vessels:glass_bottle"),
	groups = {vessel = 1}
})

if minetest.registered_items["farming:bowl"] then

minetest.register_craft({
	output = "ethereal:firethorn_jelly",
	recipe = {
		{"farming:mortar_pestle","vessels:glass_bottle", ""},
		{"ethereal:firethorn", "ethereal:firethorn", "ethereal:firethorn"},
		{"bucket:bucket_water", "bucket:bucket_water", "bucket:bucket_water"}
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty 3"},
		{"farming:mortar_pestle", "farming:mortar_pestle"}
	}
})
end
]]--
