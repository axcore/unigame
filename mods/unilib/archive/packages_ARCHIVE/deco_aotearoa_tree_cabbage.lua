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
  --cabbage tree clump
  {aotearoa.cabbage_tree1, {"aotearoa:forest_peat","default:dirt_with_grass","default:dirt_with_rainforest_litter","default:sand", "aotearoa:iron_sand",},nil,{"broadleaf_scrub","geothermal_scrub","kahikatea_swamp","coastal_scrub","pohutukawa_forest","pohutukawa_dunes","sand_dunes", "iron_sand_dunes",},lowf_max,beach_max,{offset = 0,scale = 0.005,spread = cl_spr, seed = 60715, octaves = cl_oct, persist = 0.7}},
  {aotearoa.cabbage_tree2, {"aotearoa:forest_peat","default:dirt_with_grass","default:dirt_with_rainforest_litter","default:sand", "aotearoa:iron_sand",},nil,{"broadleaf_scrub", "geothermal_scrub","kahikatea_swamp","coastal_scrub","pohutukawa_forest","pohutukawa_dunes","sand_dunes", "iron_sand_dunes",},lowf_max,beach_max,{offset = 0,scale = 0.005,spread = cl_spr, seed = 238412, octaves = cl_oct, persist = 0.7}},
  --rare cabbage tree
  {aotearoa.cabbage_tree1, {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_dry_grass",},can_rare_fill,{"hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","coastal_tussock",},lowf_max,coastf_min,},
  {aotearoa.cabbage_tree2, {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_dry_grass",},can_rare_fill,{"hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","coastal_tussock",},lowf_max,coastf_min,},
}

aotearoa.gc_deco_list = {
  --"babies" palms etc.
  {"aotearoa:cabbage_tree_crown", {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_grass","default:dirt_with_rainforest_litter","default:sand","aotearoa:iron_sand", "default:gravel"}, gc_fill_rare, {"broadleaf_scrub","geothermal_scrub","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest","coastal_scrub","pohutukawa_forest","pohutukawa_dunes","sand_dunes", "iron_sand_dunes", "gravel_dunes"},lowf_max,beach_max,},
}
]]--
