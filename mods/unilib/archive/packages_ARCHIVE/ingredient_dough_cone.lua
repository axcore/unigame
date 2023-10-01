---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("icecream:dough", {
	description = S("Cone Dough"),
	inventory_image = "icecream_dough.png",
	on_use = minetest.item_eat(1)
})
minetest.register_craft({
	output = "icecream:dough",
	recipe = {
		{"","",""},
		{"farming:flour","","farming:flour"},
		{"","group:food_egg",""},
	}
})

minetest.register_craftitem("icecream:notcone", {
	description = S("Cone-shaped dough"),
	inventory_image = "icecream_notcone.png",
	on_use = minetest.item_eat(1)
})
    minetest.register_craft({
        output = "icecream:notcone 5",
        recipe = {
            {"icecream:dough"},
        }
    })
]]--
