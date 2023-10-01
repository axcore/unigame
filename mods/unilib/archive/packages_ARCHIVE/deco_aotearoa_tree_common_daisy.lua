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
aotearoa.schem_deco_list = {
  --tree common_tree_daisy clumps.
  {aotearoa.path .. "/schematics/common_tree_daisy1.mts", {"default:dirt_with_rainforest_litter",},nil,{"muttonbird_scrub",},coastf_max,coastf_min,{offset = 0,scale = 0.07,spread = cl_spr, seed = 1641230, octaves = cl_oct, persist = 0.7}},
  {aotearoa.path .. "/schematics/common_tree_daisy2.mts", {"default:dirt_with_rainforest_litter",},nil,{"muttonbird_scrub",},coastf_max,coastf_min,{offset = 0,scale = 0.07,spread = cl_spr, seed = 3022605, octaves = cl_oct, persist = 0.7}},
  --rare common_tree_daisy
  {aotearoa.path .. "/schematics/common_tree_daisy1.mts", {"aotearoa:dirt_with_moss",},scan_rare_fill,{"pahautea_forest",},highf_max,highf_min,},
  {aotearoa.path .. "/schematics/common_tree_daisy2.mts", {"aotearoa:dirt_with_moss",},scan_rare_fill,{"pahautea_forest",},highf_max,highf_min,},
}
]]--
