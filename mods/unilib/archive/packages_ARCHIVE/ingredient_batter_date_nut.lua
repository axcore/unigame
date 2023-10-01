---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("moretrees:date_nut_batter", {
	description = S("Date-nut cake batter"),
	inventory_image = "moretrees_date_nut_batter.png",
})

-- The date-nut cake is an exceptional food item due to its highly
-- concentrated nature (32 food units). Because of that, it requires
-- many different ingredients, and, starting from the base ingredients
-- found or harvested in nature, it requires many steps to prepare.
local flour
if minetest.registered_nodes["farming:flour"] then
	flour = "farming:flour"
else
	flour = "moretrees:acorn_muffin_batter"
end
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:date_nut_batter",
	recipe = {
		"moretrees:date_nut_snack",
		"moretrees:date_nut_snack",
		"moretrees:date_nut_snack",
		"moretrees:coconut_milk",
		"moretrees:date_nut_snack",
		"moretrees:raw_coconut",
		"moretrees:coconut_milk",
		flour,
		"moretrees:raw_coconut",
	},
	replacements = {
		{ "moretrees:coconut_milk", "vessels:drinking_glass 2" }
	}
})
]]--
