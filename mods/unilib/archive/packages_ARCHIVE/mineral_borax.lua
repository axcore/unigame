---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
--
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local mineral_list= {
	{name='borax', desc=S('Borax') },
}

for i, mineral in pairs(mineral_list) do
	minetest.register_craftitem("real_minerals:"..mineral.name, {
		description = mineral.desc,
		inventory_image = "real_minerals_"..mineral.name.."_mineral.png",
	})
end
]]--
