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
	{"black_maire", "Black Maire","\n".. minetest.colorize("#adaba0", "(Nestegis cunninghamii)"),2, "flower",},
}

aotearoa.schem_deco_list = {
  --dense black_maire
  {aotearoa.path .. "/schematics/black_maire1.mts", {"aotearoa:dirt_with_dry_litter",},can_dense_fill,{"maire_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/black_maire2.mts", {"aotearoa:dirt_with_dry_litter",},can_dense_fill,{"maire_forest",},lowf_max,lowf_min,},
  --rare black_maire
  {aotearoa.path .. "/schematics/black_maire1.mts", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_dry_litter","aotearoa:dirt_with_dark_litter",},can_rare_fill,{"kamahi_forest","hinau_forest","tawa_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/black_maire2.mts", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_dry_litter","aotearoa:dirt_with_dark_litter",},can_rare_fill,{"kamahi_forest","hinau_forest","tawa_forest",},lowf_max,lowf_min,},
}
]]--
