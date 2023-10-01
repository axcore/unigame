---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/molehills
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
abstract_molehills.place_molehill = function(pos)
	local right_here	= {x=pos.x	, y=pos.y+1, z=pos.z	}
	if	minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z	}).name ~= "air"
	and minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z	}).name ~= "air"
	and minetest.get_node({x=pos.x	, y=pos.y, z=pos.z+1}).name ~= "air"
	and minetest.get_node({x=pos.x	, y=pos.y, z=pos.z-1}).name ~= "air"
	and minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z+1}).name ~= "air"
	and minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z-1}).name ~= "air"
	and minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z+1}).name ~= "air"
	and minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z-1}).name ~= "air" then
		minetest.swap_node(right_here, {name="molehills:molehill"})
	end
end

local mh_cbox = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.125, 0.5}
}

minetest.register_node("molehills:molehill",{
    drawtype = "mesh",
    mesh = "molehill_molehill.obj",
    description = S("Mole Hill"),
    inventory_image = "molehills_side.png",
    tiles = { "molehills_dirt.png" },
    paramtype = "light",
    selection_box = mh_cbox,
    collision_box = mh_cbox,
    groups = {crumbly=3},
    sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({ -- molehills --> dirt
    output = "default:dirt",
    recipe = {
        {"molehills:molehill","molehills:molehill"},
        {"molehills:molehill","molehills:molehill"},
    }
})

biome_lib.register_on_generate({
		surface = {"default:dirt_with_grass"},
		rarity = molehills_rarity,
		rarity_fertility = molehills_rarity_fertility,
		plantlife_limit = molehills_fertility,
		min_elevation = 1,
		max_elevation = 40,
		avoid_nodes = {"group:tree","group:liquid","group:stone","group:falling_node",
		avoid_radius = 4,
	},
	abstract_molehills.place_molehill
)
]]--
