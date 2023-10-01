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
	{"miro", "Miro","\n".. minetest.colorize("#adaba0", "(Prumnopitys ferruginea)"), 2,nil, "miro_fruit", "Miro Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, 1},
}

minetest.register_craft({
	output = "dye:brown 4",
  recipe = {
    {'aotearoa:miro_tree'},
    {'default:torch'},
  },
  replacements = {{"default:torch", "default:torch"}}
})

aotearoa.schem_deco_list = {
  --rare miro
  {aotearoa.path .. "/schematics/miro1.mts", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},can_rare_fill,{"kamahi_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest",},lowf_max,lowf_min,},
  {aotearoa.path .. "/schematics/miro2.mts", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",},can_rare_fill,{"kamahi_forest","beech_forest","hinau_forest","southern_podocarp_forest","maire_forest","tawa_forest","northern_podocarp_forest","kauri_forest",},lowf_max,lowf_min,},
}
]]--
