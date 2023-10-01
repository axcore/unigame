---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function add_simple_flower(name, desc, box, f_groups)

	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("bakedclay:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"baked_clay_" .. name .. ".png"},
		inventory_image = "baked_clay_" .. name .. ".png",
		wield_image = "baked_clay_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

local flowers = {
	{"thistle", "Thistle",
	{-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_magenta = 1}},
}

for _,item in pairs(flowers) do
	add_simple_flower(unpack(item))
end

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.004,
		spread = {x = 100, y = 100, z = 100},
		seed = 7134,
		octaves = 3,
		persist = 0.6
	},
	y_min = 15,
	y_max = 90,
	decoration = "bakedclay:thistle"
})
]]--
