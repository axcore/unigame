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
if ropes.woodRopeBoxMaxMultiple > 0 or ropes.create_all_definitions then
	if ropes.woodRopeBoxMaxMultiple > 0 then
		minetest.register_craft({
			output = "ropes:wood1rope_block",
			recipe =  {
				{'group:wood'},
				{'group:vines'}
			}
		})
	end
	for i = 1,9 do
		if ropes.woodRopeBoxMaxMultiple >= i or ropes.create_all_definitions then
			register_rope_block(i, ropes.woodRopeBoxMaxMultiple, S("Wood"), "wood", "#86683a", 2)
		end
	end
end
]]--
