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
aotearoa.plantlist = {
	{"kauri_grass", "Kauri Grass","\n".. minetest.colorize("#adaba0","(Astelia trinervia)"),nil,1,nil,"firelike"},
}

minetest.register_craft({
	type = "shapeless",
	output = "dye:red 4",
	recipe = {"aotearoa:kauri_grass"},
})
minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'aotearoa:kauri_grass', 'aotearoa:kauri_grass', 'aotearoa:kauri_grass'},
	}
})

aotearoa.gc_deco_list = {
  --dense kauri_grass
  {"aotearoa:kauri_grass", {"aotearoa:dirt_with_dry_litter",}, gc_fill_dense, {"kauri_forest",},lowf_max,lowf_min,},
}
]]--
