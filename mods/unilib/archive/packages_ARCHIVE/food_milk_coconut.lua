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
minetest.register_craftitem("moretrees:coconut_milk", {
	description = S("Coconut Milk"),
	inventory_image = "moretrees_coconut_milk_inv.png",
	wield_image = "moretrees_coconut_milk.png",
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {vessel = 1},
})

-- coconut milk using food_cutting_board from farming redo
if minetest.registered_items["farming:cutting_board"] then
	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:coconut_milk",
		recipe = {
			"moretrees:coconut",
			"vessels:drinking_glass",
			"group:food_cutting_board",
		},
		replacements = {
			{ "moretrees:coconut", "moretrees:raw_coconut" },
			{ "group:food_cutting_board", "farming:cutting_board" },
		}
	})
end
]]--
