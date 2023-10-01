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
  {"black_beech", "Black Beech","\n".. minetest.colorize("#adaba0", "(Fuscospora solandri)"), 2},
}

aotearoa.schem_deco_list = {
  --dense black_beech
  {aotearoa.path .. "/schematics/black_beech1.mts", {"aotearoa:dirt_with_beech_litter",},can_dense_fill,{"beech_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/black_beech2.mts", {"aotearoa:dirt_with_beech_litter",},can_fill,{"beech_forest",},lowf_max,lowf_min,},
  -- rare black_beech
  {aotearoa.path .. "/schematics/black_beech1.mts", {"aotearoa:dirt_with_dry_litter",},can_rare_fill,{"hinau_forest","maire_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/black_beech2.mts", {"aotearoa:dirt_with_dry_litter",},can_rare_fill,{"hinau_forest","maire_forest",},lowf_max,lowf_min,},
}
]]--
