---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
aotearoa.treelist = {
	{"hinau", "Hinau","\n".. minetest.colorize("#adaba0", "(Elaeocarpus dentatus)"), 2,"flower", "hinau_fruit", "Hinau Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, 1},
}

minetest.register_craft({
	type = "cooking",
	output = "dye:black 4",
	recipe = "aotearoa:hinau_tree",
})

aotearoa.schem_deco_list = {
  --dense hinau
  {aotearoa.path .. "/schematics/hinau1.mts", {"aotearoa:dirt_with_dry_litter",},can_dense_fill,{"hinau_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/hinau2.mts", {"aotearoa:dirt_with_dry_litter",},can_dense_fill,{"hinau_forest",},lowf_max,lowf_min,},
  --rare hinau
  {aotearoa.path .. "/schematics/hinau1.mts", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dry_litter",},can_rare_fill,{"kamahi_forest","beech_forest","maire_forest","kauri_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/hinau2.mts", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dry_litter",},can_rare_fill,{"kamahi_forest","beech_forest","maire_forest","kauri_forest",},lowf_max,lowf_min,},
}
]]--
