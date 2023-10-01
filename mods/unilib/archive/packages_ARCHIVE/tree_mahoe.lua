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
    {"mahoe", "Mahoe","\n".. minetest.colorize("#adaba0","(Melicytus ramiflorus)"), 2},
}

aotearoa.schem_deco_list = {
  --mahoe
  {aotearoa.path .. "/schematics/mahoe1.mts", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},scan_fill,{"broadleaf_scrub","hinau_forest","maire_forest","tawa_forest","kauri_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/mahoe2.mts", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},scan_fill,{"broadleaf_scrub","hinau_forest","maire_forest","tawa_forest","kauri_forest",},lowf_max,lowf_min,},
  --rare mahoe
  {aotearoa.path .. "/schematics/mahoe1.mts", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},scan_rare_fill,{"geothermal_scrub","kamahi_forest","beech_forest","southern_podocarp_forest","northern_podocarp_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/mahoe2.mts", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},scan_rare_fill,{"geothermal_scrub","kamahi_forest","beech_forest","southern_podocarp_forest","northern_podocarp_forest",},lowf_max,lowf_min,},
}
]]--
