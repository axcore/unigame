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
minetest.register_craftitem("aotearoa:cooked_bracken_root", {
	description = "Cooked Bracken Root",
	inventory_image = "aotearoa_cooked_bracken_root.png",
  on_use = minetest.item_eat(2),
})
minetest.register_craft({
	type = "cooking",
	output = "aotearoa:cooked_bracken_root",
	recipe = "aotearoa:bracken",
})
]]--
