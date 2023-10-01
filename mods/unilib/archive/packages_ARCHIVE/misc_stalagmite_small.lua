---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- What's a cave without speleothems?
local spel = {
	{type1="stalactite", type2="stalagmite", tile="default_stone.png"},
	{type1="stalactite_slimy", type2="stalagmite_slimy", tile="default_stone.png^valc_algae.png"},
	{type1="stalactite_mossy", type2="stalagmite_mossy", tile="default_stone.png^valc_moss.png"},
	{type1="icicle_down", type2="icicle_up", desc="Icicle", tile="caverealms_thin_ice.png", drop="default:ice"},
}

for _, desc in pairs(spel) do
	minetest.register_node("valleys_c:"..desc.type2, {
		description = (desc.desc or "Stalagmite"),
		tiles = {desc.tile},
		is_ground_content = true,
		walkable = false,
		paramtype = "light",
		--light_source = 14,
		drop = "valleys_c:stalagmite",
		drawtype = "nodebox",
		node_box = { type = "fixed", 
			fixed = {
				{-0.07, -0.5, -0.07, 0.07, 0.0, 0.07}, 
				{-0.04, 0.0, -0.04, 0.04, 0.25, 0.04}, 
				{-0.02, 0.25, -0.02, 0.02, 0.5, 0.02}, 
			} },
		groups = {rock=1, cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"", "", ""},
		{"valleys_c:stalagmite", "valleys_c:stalagmite", ""},
		{"valleys_c:stalagmite", "valleys_c:stalagmite", ""},
	},
})
]]--
