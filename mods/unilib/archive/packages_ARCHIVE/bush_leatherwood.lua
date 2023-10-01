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
aotearoa.bushlist = {
    {"leatherwood", "Leatherwood","\n".. minetest.colorize("#adaba0","(Olearia colensoi)"),},
}

aotearoa.schem_deco_list = {
  --Woody bushes....
  --dense leatherwood. muttonbird
  {aotearoa.path .. "/schematics/leatherwood1.mts", {"default:dirt_with_rainforest_litter",},scan_x_dense_fill,{"muttonbird_scrub",},coastf_max,coastf_min,},
  {aotearoa.path .. "/schematics/leatherwood2.mts", {"default:dirt_with_rainforest_litter",},scan_x_dense_fill,{"muttonbird_scrub",},coastf_max,coastf_min,},
  -- leatherwood. montane
  {aotearoa.path .. "/schematics/leatherwood1.mts", {"default:dirt_with_dry_grass","aotearoa:schist","aotearoa:dirt_with_moss",},scan_dense_fill,{"fellfield","mountain_tussock","pahautea_forest",},highf_max+2,highf_min +5,},
  {aotearoa.path .. "/schematics/leatherwood2.mts", {"default:dirt_with_dry_grass","aotearoa:schist","aotearoa:dirt_with_moss",},scan_dense_fill,{"fellfield","mountain_tussock","pahautea_forest",},highf_max+2,highf_min +5,},
}
]]--
