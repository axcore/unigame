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
aotearoa.shrublist = {
    {"matagouri", "Matagouri","\n".. minetest.colorize("#adaba0","(Discaria toumatou)"), 2, nil, 1},
}

aotearoa.schem_deco_list = {
  --matagouri clumps.
  {aotearoa.path .. "/schematics/matagouri1.mts", {"default:dirt_with_dry_grass",},nil,{"matagouri_scrub","coastal_tussock",},lowf_max,coastf_min,{offset = 0,scale = 0.01,spread = cl_spr, seed = 761090, octaves = cl_oct, persist = 0.9}},
  {aotearoa.path .. "/schematics/matagouri2.mts", {"default:dirt_with_dry_grass",},nil,{"matagouri_scrub","coastal_tussock",},lowf_max,coastf_min,{offset = 0,scale = 0.01,spread = cl_spr, seed = 413475, octaves = cl_oct, persist = 0.9}},
}
]]--
