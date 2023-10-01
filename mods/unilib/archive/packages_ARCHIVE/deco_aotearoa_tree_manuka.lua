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
  --manuka clumps.
  {aotearoa.path .. "/schematics/manuka1.mts", {"default:dirt_with_dry_grass", "default:dirt_with_grass",},nil,{"coastal_tussock","coastal_scrub",},lowf_max,coastf_min,{offset = 0,scale = 0.03,spread = cl_spr, seed = 1646630, octaves = cl_oct, persist = 0.8}},
  {aotearoa.path .. "/schematics/manuka2.mts", {"default:dirt_with_dry_grass", "default:dirt_with_grass",},nil,{"coastal_tussock","coastal_scrub",},lowf_max,coastf_min,{offset = 0,scale = 0.03,spread = cl_spr, seed = 3121165, octaves = cl_oct, persist = 0.8}},
  --rare manuka clump
  {aotearoa.path .. "/schematics/manuka1.mts", {"default:dirt_with_rainforest_litter","aotearoa:gumland_soil","aotearoa:restiad_peat"},nil,{"geothermal_scrub","gumland","fen",},lowf_max,lowf_min,{offset = 0,scale = 0.01,spread = cl_spr2, seed = 1622230, octaves = cl_oct, persist = 0.95}},
  {aotearoa.path .. "/schematics/manuka2.mts", {"default:dirt_with_rainforest_litter","aotearoa:gumland_soil","aotearoa:restiad_peat"},nil,{"geothermal_scrub","gumland","fen",},lowf_max,lowf_min,{offset = 0,scale = 0.01,spread = cl_spr2, seed = 1125565, octaves = cl_oct, persist = 0.95}},
  --dense manuka
  {aotearoa.path .. "/schematics/manuka1.mts", {"default:dirt_with_rainforest_litter",},scan_x_dense_fill,{"manuka_scrub",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/manuka2.mts", {"default:dirt_with_rainforest_litter",},scan_x_dense_fill,{"manuka_scrub",},lowf_max,lowf_min,},
}

aotearoa.gc_deco_list = {
  --stunted manuka
  {"aotearoa:manuka_leaves", {"aotearoa:gumland_soil",},nil,{"gumland",},lowf_max,lowf_min, {offset = gc_off,	scale = gc_sc_dense, spread = gc_spr2,	seed = 8787761, octaves = gc_oct, persist = 0.1}},
}
]]--
