---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("ferns:ferntuber", {
	description = S("Fern Tuber"),
	inventory_image = "ferns_ferntuber.png",
})

minetest.register_craftitem("ferns:ferntuber_roasted", {
	description = S("Roasted Fern Tuber"),
	inventory_image = "ferns_ferntuber_roasted.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	type = "cooking",
	output = "ferns:ferntuber_roasted",
	recipe = "ferns:ferntuber",
	cooktime = 3,
})
]]--
