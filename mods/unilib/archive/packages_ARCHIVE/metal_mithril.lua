---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local oredefs = {
	mithril = {
		description = "Mithril",
		makes = {ore = true, block = true, lump = true, ingot = true, chest = false},
		oredef = {
			clust_scarcity = moreores.mithril_chunk_size ^ 3,
			clust_num_ores = moreores.mithril_ore_per_chunk,
			clust_size = moreores.mithril_chunk_size,
			y_min = moreores.mithril_min_depth,
			y_max = moreores.mithril_max_depth,
		},
		tools = {
			pick = {
				groupcaps = {
					cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = 200, maxlevel = 3},
				},
				damage_groups = {fleshy = 6},
			},
			hoe = {
				max_uses = 1000,
			},
			shovel = {
				groupcaps = {
					crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = 200, maxlevel = 3},
				},
				damage_groups = {fleshy = 5},
			},
			axe = {
				groupcaps = {
					choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = 200, maxlevel = 3},
					fleshy = {times = {[2] = 0.95, [3] = 0.30}, uses = 200, maxlevel = 2},
				},
				damage_groups = {fleshy = 8},
			},
			sword = {
				groupcaps = {
					fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = 200, maxlevel = 2},
					snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = 200, maxlevel = 3},
					choppy = {times = {[3] = 0.65}, uses = 200, maxlevel = 0},
				},
				damage_groups = {fleshy = 10},
			},
		},
		full_punch_interval = 0.45,
	}
}

register_dust("Mithril",         "moreores:mithril_ingot")
]]--
