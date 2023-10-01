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
aotearoa.treelist = {
	{"mountain_beech", "Mountain Beech","\n".. minetest.colorize("#adaba0", "(Fuscospora cliffortioides)"),2},
}

aotearoa.schem_deco_list = {
  --dense mountain_beech
  {aotearoa.path .. "/schematics/mountain_beech1.mts", {"aotearoa:dirt_with_moss",},scan_dense_fill,{"mountain_beech_forest",},highf_max,highf_min,},
  {aotearoa.path .. "/schematics/mountain_beech2.mts", {"aotearoa:dirt_with_moss",},scan_dense_fill,{"mountain_beech_forest",},highf_max,highf_min,},
  --rare mountain_beech
  {aotearoa.path .. "/schematics/mountain_beech1.mts", {"aotearoa:dirt_with_moss",},can_rare_fill,{"kamahi_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/mountain_beech2.mts", {"aotearoa:dirt_with_moss",},can_rare_fill,{"kamahi_forest",},lowf_max,lowf_min,},
}
]]--
