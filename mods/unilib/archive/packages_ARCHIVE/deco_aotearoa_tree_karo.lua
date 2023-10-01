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
  --karo clumps.
  {aotearoa.path .. "/schematics/karo1.mts", {"default:dirt_with_grass","default:sand","aotearoa:iron_sand","default:gravel"},nil,{"coastal_scrub","pohutukawa_forest","pohutukawa_dunes","sand_dunes", "iron_sand_dunes", "gravel_dunes"},coastf_max,beach_max,{offset = 0,scale = 0.01,spread = cl_spr, seed = 120140, octaves = cl_oct, persist = 0.7}},
  {aotearoa.path .. "/schematics/karo2.mts", {"default:dirt_with_grass","default:sand","aotearoa:iron_sand","default:gravel"},nil,{"coastal_scrub","pohutukawa_forest","pohutukawa_dunes","sand_dunes", "iron_sand_dunes", "gravel_dunes"},coastf_max,beach_max,{offset = 0,scale = 0.01,spread = cl_spr, seed = 304525, octaves = cl_oct, persist = 0.7}},
  --karo subcanopy.
  {aotearoa.path .. "/schematics/karo1.mts", {"default:dirt_with_rainforest_litter",},scan_fill,{"pohutukawa_forest",},coastf_max,coastf_min,},
  {aotearoa.path .. "/schematics/karo2.mts", {"default:dirt_with_rainforest_litter",},scan_fill,{"pohutukawa_forest",},coastf_max,coastf_min,},
}
]]--
