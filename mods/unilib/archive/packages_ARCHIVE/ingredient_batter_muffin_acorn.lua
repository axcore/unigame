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
minetest.register_craftitem("moretrees:acorn_muffin_batter", {
	description = S("Acorn Muffin batter"),
	inventory_image = "moretrees_acorn_muffin_batter.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:acorn_muffin_batter",
	recipe = {
		"moretrees:acorn",
		"moretrees:acorn",
		"moretrees:acorn",
		"moretrees:acorn",
		"moretrees:coconut_milk",
	},
	replacements = {
		{ "moretrees:coconut_milk", "vessels:drinking_glass" }
	}
})
]]--
