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
minetest.register_node("aotearoa:raupo", {
	description = "Raupo\n".. minetest.colorize("#adaba0","(Typha orientalis)"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"aotearoa_raupo.png"},
	inventory_image = "aotearoa_raupo.png",
	wield_image = "aotearoa_raupo.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dry_grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
	},
	after_dig_node = function(pos, node, metadata, digger)
		aotearoa.dig_up(pos, {"aotearoa:raupo", "aotearoa:raupo_flower"}, digger)
	end,
})
minetest.register_craft({
	type = "fuel",
	recipe = "aotearoa:raupo",
	burntime = 1,
})
minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'aotearoa:raupo', 'aotearoa:raupo', 'aotearoa:raupo'},
	}
})

minetest.register_node("aotearoa:raupo_flower", {
	description = "Raupo Flower\n".. minetest.colorize("#adaba0","(Typha orientalis)"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"aotearoa_raupo_flower.png"},
	inventory_image = "aotearoa_raupo_flower.png",
	wield_image = "aotearoa_raupo_flower.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dry_grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
	},
})
minetest.register_craft({
	type = "fuel",
	recipe = "aotearoa:raupo_flower",
	burntime = 1,
})

aotearoa.schem_deco_list = {
  --raupo
  {aotearoa.raupo1, {"aotearoa:mud_sinking",},0.7,{"raupo_swamp",},lowf_max/2,coastf_min+2,},
  {aotearoa.raupo2, {"aotearoa:mud_sinking",},0.7,{"raupo_swamp",},lowf_max/2,coastf_min+2,},
}
]]--
