---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
abstract_youngtrees.grow_youngtree = function(pos)
	local height = math.random(1,3)
	abstract_youngtrees.grow_youngtree_node(pos,height)
end


abstract_youngtrees.grow_youngtree_node = function(pos, height)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	local above_right_here = {x=pos.x, y=pos.y+2, z=pos.z}

	if minetest.get_node(right_here).name == "air"	-- instead of check_air = true,
	or minetest.get_node(right_here).name == "default:junglegrass" then
		if height == 1 then
			minetest.swap_node(right_here, {name="youngtrees:youngtree_top"})
		end
		if height == 2 then
			minetest.swap_node(right_here, {name="youngtrees:youngtree_bottom"})
			minetest.swap_node(above_right_here, {name="youngtrees:youngtree_top"})
		end
		if height == 3 then
			local two_above_right_here = {x=pos.x, y=pos.y+3, z=pos.z}
			minetest.swap_node(right_here, {name="youngtrees:youngtree_bottom"})
			minetest.swap_node(above_right_here, {name="youngtrees:youngtree_middle"})
			minetest.swap_node(two_above_right_here, {name="youngtrees:youngtree_top"})
		end
	end
end

minetest.register_node("youngtrees:youngtree_top", {
	description = S("Young Tree (top)"),
	drawtype = "plantlike",
	tiles = {"youngtree16xa.png"},
	inventory_image = "youngtree16xa.png",
	wield_image = "youngtree16xa.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_node("youngtrees:youngtree_middle", {
	description = S("Young Tree (middle)"),
	drawtype = "plantlike",
	tiles = {"youngtree16xb.png"},
	inventory_image = "youngtree16xb.png",
	wield_image = "youngtree16xb.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_node("youngtrees:youngtree_bottom", {
	description = S("Young Tree (bottom)"),
	drawtype = "plantlike",
	tiles = {"youngtree16xc.png"},
	inventory_image = "youngtree16xc.png",
	wield_image = "youngtree16xc.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

biome_lib.register_on_generate({
		surface = {
			"default:dirt_with_grass",
			"stoneage:grass_with_silex",
			"sumpf:peat",
			"sumpf:sumpf"
		},
		rarity = youngtrees_youngtrees_rarity,
		rarity_fertility = youngtrees_youngtrees_rarity_fertility,
		plantlife_limit = youngtrees_youngtrees_fertility,
		min_elevation = 1, -- above sea level
	},
	abstract_youngtrees.grow_youngtree
)
]]--
