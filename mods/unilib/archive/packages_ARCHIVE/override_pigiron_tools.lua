---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.override_item("default:axe_bronze", {
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			choppy = {
				times = {[1] = 2.50, [2] = 1.40, [3] = 1.00},
				uses = 20, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 4}
	}
})

minetest.override_item("default:axe_steel", {
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			choppy = {
				times = {[1] = 2.75, [2] = 1.70, [3] = 1.15},
				uses = 20, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 4}
	}
})

minetest.override_item("default:pick_bronze", {
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			cracky = {
				times = {[1] = 4.00, [2] = 1.60, [3] = 0.80},
				uses = 20, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 4}
	}
})

minetest.override_item("default:pick_steel", {
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			cracky = {
				times = {[1] = 4.50, [2] = 1.80, [3] = 0.90},
				uses = 20, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 4}
	}
})

minetest.override_item("default:shovel_bronze", {
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {
				times = {[1] = 1.50, [2] = 0.90, [3] = 0.40},
				uses = 30, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 3}
	}
})

minetest.override_item("default:shovel_steel", {
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {
				times = {[1] = 1.65, [2] = 1.05, [3] = 0.45},
				uses = 25, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 3}
	}
})

minetest.override_item("default:sword_bronze", {
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = {
				times = {[1] = 2.5, [2] = 1.20, [3] = 0.35},
				uses = 30, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 6}
	}
})

minetest.override_item("default:sword_steel", {
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = {
				times = {[1] = 2.75, [2] = 1.30, [3] = 0.375},
				uses = 25, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 6}
	}
})
]]--
