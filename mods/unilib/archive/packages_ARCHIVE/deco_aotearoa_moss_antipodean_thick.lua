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
  --dense moss
  {"aotearoa:moss", {"aotearoa:dirt_with_beech_litter","aotearoa:restiad_peat","aotearoa:forest_peat","default:dirt_with_rainforest_litter","aotearoa:andesite", "aotearoa:dirt_with_moss"}, gc_fill_x_dense, {"alpine_peat_bog","mountain_beech_forest","pahautea_forest","kamahi_forest","fiordland_forest","peat_bog","kahikatea_swamp","muttonbird_scrub","subantarctic_shore","subantarctic_coast",},highf_max,beach_max,},
  --rare moss clumps
  {"aotearoa:moss", {"default:dirt_with_rainforest_litter","aotearoa:schist","default:dirt_with_dry_grass","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","aotearoa:restiad_peat","aotearoa:gumland_soil",},nil, {"broadleaf_scrub", "geothermal_scrub","fellfield","mountain_tussock","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","gumland","fen",},alp_max,lowf_min,{offset = gc_off, scale =gc_scale, spread = gc_spr2,	seed = 8755361, octaves = gc_oct, persist = 0.7}},
}
]]--
