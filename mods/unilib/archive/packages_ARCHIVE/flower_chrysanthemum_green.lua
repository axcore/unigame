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
		"chrysanthemum_green",
		S("Green Chrysanthemum"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
		{color_green = 1, flammable = 1}
	},
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end

function flowers.register_decorations()
	register_flower(800081,  "chrysanthemum_green")
end
]]--
