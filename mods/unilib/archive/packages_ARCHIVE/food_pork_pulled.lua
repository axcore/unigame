---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bbq:pulled_pork", {
	description = ("Pulled Pork"),
	inventory_image = "bbq_pulled_pork.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	output = "bbq:pulled_pork 2",
	type = "shapeless",
	recipe = {"mobs:pork_cooked", "farming:bread", "bbq:bbq_sauce"}
})
]]--
