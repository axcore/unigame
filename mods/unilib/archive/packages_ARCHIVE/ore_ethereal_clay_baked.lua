---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local add_stratum = function(y_min, y_max, node)

	minetest.register_ore({
		ore_type         = "stratum",
		ore              = node,
		wherein          = {"bakedclay:orange"},
		clust_scarcity   = 1,
		y_max            = y_max,
		y_min            = y_min,
		biomes = {"mesa"}
	})
end

add_stratum(5, 10, "bakedclay:red")
add_stratum(15, 20, "bakedclay:grey")
add_stratum(25, 30, "bakedclay:red")
add_stratum(35, 40, "bakedclay:grey")
add_stratum(45, 50, "bakedclay:red")
add_stratum(55, 60, "bakedclay:grey")
]]--
