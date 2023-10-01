---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[local oredefs = {
	silver = {
		description = "Silver",
		makes = {ore = true, block = true, lump = true, ingot = true, chest = true},
		oredef = {
			clust_scarcity = moreores.silver_chunk_size ^ 3,
			clust_num_ores = moreores.silver_ore_per_chunk,
			clust_size = moreores.silver_chunk_size,
			y_min = moreores.silver_min_depth,
			y_max = moreores.silver_max_depth,
		},
		tools = {
			pick = {
				groupcaps = {
					cracky = {times = {[1] = 2.60, [2] = 1.00, [3] = 0.60}, uses = 100, maxlevel = 1},
				},
				damage_groups = {fleshy = 4},
			},
			hoe = {
				max_uses = 300,
			},
			shovel = {
				groupcaps = {
					crumbly = {times = {[1] = 1.10, [2] = 0.40, [3] = 0.25}, uses = 100, maxlevel = 1},
				},
				damage_groups = {fleshy = 3},
			},
			axe = {
				groupcaps = {
					choppy = {times = {[1] = 2.50, [2] = 0.80, [3] = 0.50}, uses = 100, maxlevel = 1},
					fleshy = {times = {[2] = 1.10, [3] = 0.60}, uses = 100, maxlevel = 1},
				},
				damage_groups = {fleshy = 5},
			},
			sword = {
				groupcaps = {
					fleshy = {times = {[2] = 0.70, [3] = 0.30}, uses = 100, maxlevel = 1},
					snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.30}, uses = 100, maxlevel = 1},
					choppy = {times = {[3] = 0.80}, uses = 100, maxlevel = 0},
				},
				damage_groups = {fleshy = 6},
			},
		},
		full_punch_interval = 1.0,
	},
}
]]--
