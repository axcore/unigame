---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- patterned glass
local pattern_list = {   --{name, description, image}
	{"stainedglass_tiles_dark", "Stained Glass", "stainedglass_tiles1",},
	{"stainedglass_tiles_pale", "Stained Glass", "stainedglass_tiles2",},
	{"stainedglass_pattern01", "Stained Glass", "stainedglass_pattern01",},
	{"stainedglass_pattern02", "Cage Glass", "stainedglass_pattern02",},
	{"stainedglass_pattern03", "Stained Glass", "stainedglass_pattern03",},
	{"stainedglass_pattern04", "Stained Glass Cross", "stainedglass_pattern04",},
	{"stainedglass_pattern05", "Stained Glass", "stainedglass_pattern05",},
}

for i in ipairs(pattern_list) do
	local name = pattern_list[i][1]
	local description = pattern_list[i][2]
	local image = pattern_list[i][3]

	minetest.register_node("abriglass:"..name, {
		description = description,
		tiles = {"abriglass_"..image..".png"},
		groups = {cracky = 3},
		use_texture_alpha = "blend",
		sunlight_propagates = true,
		light_source = 5,
		drawtype = "glasslike",
		paramtype = "light",
		paramtype2 = "facedir",
		sounds = default.node_sound_glass_defaults(),
	})
end

minetest.register_craft({
	output = 'abriglass:stainedglass_pattern04 9',
	recipe = {
		{sg_conversion_table['green'], sg_conversion_table['red'], sg_conversion_table['green'] },
		{sg_conversion_table['red'], sg_conversion_table['blue'], sg_conversion_table['red'] },
		{sg_conversion_table['green'], sg_conversion_table['red'], sg_conversion_table['green'] },
	}
})

-- cooking recipes
local cook_list = {
	"stainedglass_pattern01",
	"stainedglass_pattern02",
	"stainedglass_pattern03",
	"stainedglass_pattern04",
	"stainedglass_pattern05",
	"stainedglass_tiles_dark",
	"stainedglass_tiles_pale"
}

for i = 1, #cook_list do
	local name = cook_list[i]

	minetest.register_craft({
		type = "cooking",
		recipe = "abriglass:"..name,
		output = "abriglass:clear_glass",
	})
end
]]--
