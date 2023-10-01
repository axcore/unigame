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
  --rotten stump
  {aotearoa.stump1, {"aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","aotearoa:restiad_peat","aotearoa:gumland_soil","aotearoa:forest_peat",},can_sparse_fill,{"fiordland_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","fen","gumland","kahikatea_swamp",},lowf_max,coastf_min+2,},
  {aotearoa.stump2, {"aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","aotearoa:restiad_peat","aotearoa:gumland_soil","aotearoa:forest_peat",},can_sparse_fill,{"fiordland_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","fen","gumland","kahikatea_swamp",},lowf_max,coastf_min+2,},
  --dense rotten stump
  {aotearoa.stump1, {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss",},can_fill,{"manuka_scrub","broadleaf_scrub","geothermal_scrub","mountain_beech_forest","pahautea_forest","kamahi_forest",},highf_max,lowf_min,},
  {aotearoa.stump2, {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss",},can_fill,{"manuka_scrub","broadleaf_scrub","geothermal_scrub","mountain_beech_forest","pahautea_forest","kamahi_forest",},highf_max,lowf_min,},
}

aotearoa.gc_deco_list = {
  --rotten stump
  {"aotearoa:rotten_wood", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","aotearoa:restiad_peat","aotearoa:gumland_soil","aotearoa:forest_peat","default:dirt_with_rainforest_litter",},gc_fill_rare,{"mountain_beech_forest","pahautea_forest","manuka_scrub","broadleaf_scrub","geothermal_scrub","kamahi_forest","fiordland_forest","beech_forest","hinau_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","fen","gumland","kahikatea_swamp",},highf_max,coastf_min+2,},
}
]]--
