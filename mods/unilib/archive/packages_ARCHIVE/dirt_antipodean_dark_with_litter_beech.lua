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
aotearoa.dirtlist = {
	{"dirt_with_beech_litter", "Dirt with Beech Litter", "aotearoa_dirt_with_dark_litter_bottom.png", "aotearoa_dirt_with_dark_litter_bottom.png"},
}

for i in ipairs(aotearoa.dirtlist) do
	local dirtname = aotearoa.dirtlist[i][1]
	local dirtdesc = aotearoa.dirtlist[i][2]
	local bottext = aotearoa.dirtlist[i][3]
	local sidetext = aotearoa.dirtlist[i][4]

		minetest.register_node("aotearoa:"..dirtname, {
			description = dirtdesc,
			tiles = {
				"aotearoa_"..dirtname..".png",
				bottext,
				{name =sidetext.."^aotearoa_"..dirtname.."_side.png",
				tileable_vertical = false}
			},
			groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
			drop = "default:dirt",
			sounds = default.node_sound_dirt_defaults({
				footstep = {name = "default_grass_footstep", gain = 0.4},
			}),
		})

end
]]--
