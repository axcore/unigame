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
	{"pohutukawa", "Pohutukawa","\n".. minetest.colorize("#adaba0","(Metrosideros excelsa)"), 3, "flower"},
}

aotearoa.schem_deco_list = {
  --rare pohutukawa on dunes.
  {aotearoa.path .. "/schematics/pohutukawa1.mts", {"default:sand",},can_rare_fill,{"pohutukawa_dunes",},dune_max,beach_max,},
  {aotearoa.path .. "/schematics/pohutukawa2.mts", {"default:sand",},can_rare_fill,{"pohutukawa_dunes",},dune_max,beach_max,},
  --pohutukawa forest
  {aotearoa.path .. "/schematics/pohutukawa1.mts", {"default:dirt_with_rainforest_litter",},can_sparse_fill,{"pohutukawa_forest",},coastf_max,coastf_min,},
  {aotearoa.path .. "/schematics/pohutukawa2.mts", {"default:dirt_with_rainforest_litter",},can_sparse_fill,{"pohutukawa_forest",},coastf_max,coastf_min,},
}
]]--
