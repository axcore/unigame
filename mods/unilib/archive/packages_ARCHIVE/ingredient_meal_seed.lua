---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("aotearoa:seed_meal", {
	description = "Seed Meal",
	inventory_image = "aotearoa_cooked_karaka_kernels.png",
  --on_use = minetest.item_eat(2),
})
minetest.register_craft({
	type = "shapeless",
	output = "aotearoa:seed_meal",
	recipe = {"aotearoa:hinau_fruit", "aotearoa:hinau_fruit", "aotearoa:hinau_fruit", "aotearoa:hinau_fruit"}
})
minetest.register_craft({
	type = "shapeless",
	output = "aotearoa:seed_meal",
	recipe = {"aotearoa:karaka_fruit", "aotearoa:karaka_fruit", "aotearoa:karaka_fruit", "aotearoa:karaka_fruit"}
})
minetest.register_craft({
	type = "shapeless",
	output = "aotearoa:seed_meal",
	recipe = {"aotearoa:tawa_fruit", "aotearoa:tawa_fruit", "aotearoa:tawa_fruit", "aotearoa:tawa_fruit"}
})
]]--
