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
		"dandelion_yellow",
		S("Yellow Dandelion"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16},
		{color_yellow = 1, flammable = 1}
	},
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end

function flowers.register_decorations()
	register_flower(1220999, "dandelion_yellow")
end
]]--
