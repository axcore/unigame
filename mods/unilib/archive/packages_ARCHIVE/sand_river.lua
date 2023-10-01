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
aotearoa.sandlist = {
	{"river_sand", "River Sand"},
}

for i in ipairs(aotearoa.sandlist) do
	local sandname = aotearoa.sandlist[i][1]
	local sanddesc = aotearoa.sandlist[i][2]

		minetest.register_node("aotearoa:"..sandname, {
			description = sanddesc,
			tiles = {	"aotearoa_"..sandname..".png"},
			groups = {crumbly = 3, falling_node = 1, sand = 1},
			sounds = default.node_sound_sand_defaults(),
		})

end
]]--
