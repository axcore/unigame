---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Paper (2x3 string = 4 paper)
minetest.register_craft({
	output = "default:paper 2",
	recipe = {
		{"farming:cotton", "farming:cotton", "farming:cotton"}
	}
})
]]--
