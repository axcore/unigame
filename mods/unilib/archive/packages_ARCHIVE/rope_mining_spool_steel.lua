---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if ropes.steelRopeBoxMaxMultiple > 0 or ropes.create_all_definitions then
	if ropes.steelRopeBoxMaxMultiple > 0 then
		minetest.register_craft({
			output = "ropes:steel1rope_block",
			recipe =  {
				{'default:steel_ingot'},
				{'group:vines'}
			}
		})
	end
	for i = 1,9 do
		if ropes.steelRopeBoxMaxMultiple >= i or ropes.create_all_definitions then
			register_rope_block(i, ropes.steelRopeBoxMaxMultiple, S("Steel"), "steel", "#ffffff")
		end
	end
end
]]--
