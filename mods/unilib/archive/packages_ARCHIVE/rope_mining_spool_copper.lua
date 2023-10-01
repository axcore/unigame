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
if ropes.copperRopeBoxMaxMultiple > 0 or ropes.create_all_definitions then
	if ropes.copperRopeBoxMaxMultiple > 0 then
		minetest.register_craft({
			output = "ropes:copper1rope_block",
			recipe =  {
				{'default:copper_ingot'},
				{'group:vines'}
			}
		})
	end
	for i = 1,9 do
		if ropes.copperRopeBoxMaxMultiple >= i or ropes.create_all_definitions then
			register_rope_block(i, ropes.copperRopeBoxMaxMultiple, S("Copper"), "copper", "#c88648")
		end
	end
end
]]--
