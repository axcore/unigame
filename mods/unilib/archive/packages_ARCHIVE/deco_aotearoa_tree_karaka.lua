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
  --rare karaka.
  {aotearoa.path .. "/schematics/karaka1.mts", {"default:dirt_with_rainforest_litter",},can_rare_fill,{"pohutukawa_forest",},coastf_max,coastf_min+2,},
  {aotearoa.path .. "/schematics/karaka2.mts", {"default:dirt_with_rainforest_litter",},can_rare_fill,{"pohutukawa_forest",},coastf_max,coastf_min+2,},
  --karaka groves.
  {aotearoa.path .. "/schematics/karaka1.mts", {"default:dirt_with_grass",},nil,{"coastal_scrub",},coastf_max,coastf_min+2,{offset = 0,scale = 0.004,spread = cl_spr, seed = 45254, octaves = cl_oct, persist = 0.8}},
  {aotearoa.path .. "/schematics/karaka2.mts", {"default:dirt_with_grass",},nil,{"coastal_scrub",},coastf_max,coastf_min+2,{offset = 0,scale = 0.004,spread = cl_spr, seed = 108761, octaves = cl_oct, persist = 0.8}},
}
]]--
