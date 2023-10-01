---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bucket
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Register buckets as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		{name = "bucket:bucket_empty", chance = 0.55},
		-- water in deserts/ice or above ground, lava otherwise
		{name = "bucket:bucket_water", chance = 0.45,
			types = {"sandstone", "desert", "ice"}},
		{name = "bucket:bucket_water", chance = 0.45, y = {0, 32768},
			types = {"normal"}},
		{name = "bucket:bucket_lava", chance = 0.45, y = {-32768, -1},
			types = {"normal"}},
	})
end
]]--
