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
		"dandelion_white",
		S("White Dandelion"),
		{-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16},
		{color_white = 1, flammable = 1}
	},
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end

function flowers.register_decorations()
	register_flower(73133,   "dandelion_white")
end
]]--
