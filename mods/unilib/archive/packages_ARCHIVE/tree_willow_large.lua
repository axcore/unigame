---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
moretrees.treelist = {
	{"willow",       S("Willow Tree")},
}
moretrees.willow_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 337,
	min_elevation = -5,
	max_elevation = 5,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 5,
	rarity = 75,
	max_count = 5,
}
]]--

--  moretrees.willow_model={
--      axiom="FFFFFFFFccA",
--      rules_a="[&FF&FFFF&&F&FFFFFFFdddd][**&FF&FFFF&&F&FFFFFFFdddd][//&FF&FFFF&&F&FFFFFFFdddd][////&FF&FFFF&&F&FFFFFFFdddd][//////&FF&FFFF&&F&FFFFFFFdddd][////////&FF&FFFF&&F&FFFFFFFdddd]",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:willow_trunk",
--      leaves="moretrees:willow_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="crossed",
--      thin_branches=true
--  }

