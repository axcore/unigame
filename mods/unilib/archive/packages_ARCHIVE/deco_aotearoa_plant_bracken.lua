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
aotearoa.gc_deco_list = {
  --sparse bracken
  {"aotearoa:bracken", {"default:dirt_with_rainforest_litter"}, gc_fill_rare, {"pohutukawa_forest"},coastf_max,coastf_min +2,},
  --clumped bracken
  {"aotearoa:bracken", {"default:dirt_with_grass",}, nil, {"coastal_scrub",},lowf_max,coastf_min +2,{offset = gc_off,	scale = gc_scale, spread = gc_spr,	seed = 557864, octaves = gc_oct, persist = gc_pers}},
  --dense bracken
  {"aotearoa:bracken", {"default:dirt_with_rainforest_litter"}, gc_fill_dense, {"manuka_scrub","geothermal_scrub", "broadleaf_scrub"},lowf_max,lowf_min,},
}
]]--
