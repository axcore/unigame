---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("darkage:iron_stick", {
	description = "Iron Stick",
	inventory_image = "darkage_iron_stick.png",
})
minetest.register_craft({
	output = "darkage:iron_stick 4",
	recipe = {
		{"default:steel_ingot"},
	}
})
]]--
