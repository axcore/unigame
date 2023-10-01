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
minetest.register_craftitem("aotearoa:pungapunga", {
	description = "Pungapunga Pollen Cake",
	inventory_image = "aotearoa_pungapunga.png",
  on_use = minetest.item_eat(2),
})
minetest.register_craft({
	type = "cooking",
	output = "aotearoa:pungapunga",
	recipe = "aotearoa:raupo_flower",
})
]]--
