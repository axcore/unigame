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
  --wheki clump
  {aotearoa.wheki2, {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},nil,{"manuka_scrub","broadleaf_scrub","geothermal_scrub","kamahi_forest","fiordland_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest",},lowf_max,lowf_min,{offset = 0,scale = 0.005,spread = cl_spr, seed = 688807, octaves = cl_oct, persist = 0.7}},
  {aotearoa.wheki1, {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},nil,{"manuka_scrub","broadleaf_scrub","geothermal_scrub","kamahi_forest","fiordland_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest",},lowf_max,lowf_min,{offset = 0,scale = 0.005,spread = cl_spr, seed = 564592, octaves = cl_oct, persist = 0.7}},
  --dense wheki
  {aotearoa.wheki2, {"default:dirt_with_rainforest_litter",},scan_x_dense_fill,{"broadleaf_scrub",},lowf_max,lowf_min,},
  {aotearoa.wheki1, {"default:dirt_with_rainforest_litter",},scan_dense_fill,{"broadleaf_scrub",},lowf_max,lowf_min,},
}

aotearoa.gc_deco_list = {
  --"babies" palms etc.
  {"aotearoa:wheki_crown", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",}, gc_fill_rare, {"manuka_scrub","broadleaf_scrub","geothermal_scrub","kamahi_forest","fiordland_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest",},lowf_max,lowf_min,},
}
]]--
