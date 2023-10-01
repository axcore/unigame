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
  --nikau palm clump
  {aotearoa.nikau_palm1, {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_grass","default:dirt_with_rainforest_litter",},nil,{"maire_forest","tawa_forest","kauri_forest","coastal_scrub","pohutukawa_forest",},lowf_max,coastf_min +2,{offset = 0,scale = 0.005,spread = cl_spr, seed = 603507, octaves = cl_oct, persist = 0.7}},
  {aotearoa.nikau_palm2, {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_grass","default:dirt_with_rainforest_litter",},nil,{"maire_forest","tawa_forest","kauri_forest","coastal_scrub","pohutukawa_forest",},lowf_max,coastf_min +2,{offset = 0,scale = 0.005,spread = cl_spr, seed = 542122, octaves = cl_oct, persist = 0.7}},
  --rare nikau palm
  {aotearoa.nikau_palm1, {"aotearoa:dirt_with_dry_litter","aotearoa:dirt_with_dark_litter","default:dirt_with_dry_grass",},can_rare_fill,{"hinau_forest","southern_podocarp_forest","northern_podocarp_forest","coastal_tussock",},lowf_max,coastf_min +2,},
  {aotearoa.nikau_palm2, {"aotearoa:dirt_with_dry_litter","aotearoa:dirt_with_dark_litter","default:dirt_with_dry_grass",},can_rare_fill,{"hinau_forest","northern_podocarp_forest","southern_podocarp_forest","coastal_tussock",},lowf_max,coastf_min +2,},
}

aotearoa.gc_deco_list = {
  --"babies" palms etc.
  {"aotearoa:nikau_palm_crown", {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_grass","default:dirt_with_rainforest_litter",}, gc_fill_rare, {"hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","coastal_scrub","pohutukawa_forest",},lowf_max,coastf_min +2},
}
]]--
