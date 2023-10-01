---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local materials
if minetest.get_modpath("castle_masonry") then
	materials = castle_masonry.materials
else
	materials = {{name="stonebrick", desc=S("Stonebrick"), tile="default_stone_brick.png", craft_material="default:stonebrick"}}
end

for _, material in pairs(materials) do
	castle_lighting.register_pillar_brasier(material)
end
]]--
