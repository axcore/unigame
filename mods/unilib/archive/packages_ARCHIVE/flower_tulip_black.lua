---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
flowers.datas = {
	{
		"tulip_black",
		S("Black Tulip"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
		{color_black = 1, flammable = 1}
	},
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end

function flowers.register_decorations()
	register_flower(19822,   "tulip")
	register_flower(42,      "tulip_black")
end
]]--
