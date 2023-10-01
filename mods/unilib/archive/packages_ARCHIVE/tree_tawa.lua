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
  {"tawa", "Tawa","\n".. minetest.colorize("#adaba0", "(Beilschmiedia tawa)"), 3,nil, "tawa_fruit", "Tawa Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, 1},
}

aotearoa.schem_deco_list = {
  -- Tawa
  {aotearoa.path .. "/schematics/tawa1.mts", {"aotearoa:dirt_with_dry_litter",},can_fill,{"kauri_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/tawa2.mts", {"aotearoa:dirt_with_dry_litter",},can_fill,{"kauri_forest",},lowf_max,lowf_min,},
  -- dense Tawa
  {aotearoa.path .. "/schematics/tawa1.mts", {"aotearoa:dirt_with_dark_litter",},can_dense_fill,{"tawa_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/tawa2.mts", {"aotearoa:dirt_with_dark_litter",},can_dense_fill,{"tawa_forest",},lowf_max,lowf_min,},
  -- rare Tawa
  {aotearoa.path .. "/schematics/tawa1.mts", {"aotearoa:dirt_with_dry_litter",},can_rare_fill,{"maire_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/tawa2.mts", {"aotearoa:dirt_with_dry_litter",},can_rare_fill,{"maire_forest",},lowf_max,lowf_min,},
}
]]--
