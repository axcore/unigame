---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
beautiflowers.flowers ={
    {"bonsai_1","green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"bonsai_2","brown", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"bonsai_3","green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"bonsai_4","brown", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"bonsai_5","dark_green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
}

minetest.register_craft({
	output = "beautiflowers:bonsai_1",
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:sapling", "default:cobble"},
        {"default:cobble", "default:cobble", "default:cobble"}
	}
})

minetest.register_craft({
	output = "beautiflowers:bonsai_2",
	recipe = {
		{"default:cobble", "default:sapling", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
        {"default:cobble", "default:sapling", "default:cobble"}
	}
})

minetest.register_craft({
	output = "beautiflowers:bonsai_3",
	recipe = {
		{"default:cobble", "default:sapling", "default:cobble"},
		{"default:cobble", "default:sapling", "default:cobble"},
        {"default:cobble", "default:sapling", "default:cobble"}
	}
})

minetest.register_craft({
	output = "beautiflowers:bonsai_4",
	recipe = {
		{"default:cobble", "default:sapling", "default:cobble"},
		{"default:sapling", "default:cobble", "default:sapling"},
        {"default:cobble", "default:sapling", "default:cobble"}
	}
})

minetest.register_craft({
	output = "beautiflowers:bonsai_5",
	recipe = {
		{"default:cobble", "default:sapling", "default:cobble"},
		{"default:sapling", "default:sapling", "default:sapling"},
        {"default:cobble", "default:sapling", "default:cobble"}
	}
})

local function register_bonsai(name)

	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:stone","default:cobble","default:mossycobble"},
		sidelen = 16,
		noise_params = {
			offset = -0.006,
			scale = 0.07,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66,
		},
		y_max = 30000,
		y_min = 30,
		decoration = "beautiflowers:"..name,
	})

end

function beautiflowers.bonsai_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 3 then
		if minetest.get_node_light(pos, nil) == 15 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"group:stone"})
	if #positions == 0 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 3 then
		minetest.set_node(pos2, {name = node.name})
	end
end

minetest.register_abm({
	label = "Bonsai spread",
	nodenames = {"beautiflowers:bonsai_1","beautiflowers:bonsai_2","beautiflowers:bonsai_3","beautiflowers:bonsai_4","beautiflowers:bonsai_5"},
	interval = 11,
	chance = 150,
	action = function(...)
		beautiflowers.bonsai_spread(...)
	end,
})
]]--
