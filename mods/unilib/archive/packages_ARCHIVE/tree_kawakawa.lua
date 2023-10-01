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
    {"kawakawa", "Kawakawa","\n".. minetest.colorize("#adaba0","(Piper excelsum)"), 2,nil, 0, "kawakawa_fruit", "Kawakawa Fruit",{-0.2, -0.5, -0.2, 0.2, 0, 0.2},   0.8, 1},
}

aotearoa.schem_deco_list = {
  --kawakawa
  {aotearoa.path .. "/schematics/kawakawa1.mts", {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},scan_fill,{"maire_forest","tawa_forest","kauri_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/kawakawa2.mts", {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},scan_fill,{"maire_forest","tawa_forest","kauri_forest",},lowf_max,lowf_min,},
  --rare kawakawa
  {aotearoa.path .. "/schematics/kawakawa1.mts", {"aotearoa:dirt_with_dark_litter","default:dirt_with_rainforest_litter",},scan_rare_fill,{"northern_podocarp_forest","pohutukawa_forest",},lowf_max,coastf_min+2,},
  {aotearoa.path .. "/schematics/kawakawa2.mts", {"aotearoa:dirt_with_dark_litter","default:dirt_with_rainforest_litter",},scan_rare_fill,{"northern_podocarp_forest","pohutukawa_forest",},lowf_max,coastf_min+2,},
}
]]--
