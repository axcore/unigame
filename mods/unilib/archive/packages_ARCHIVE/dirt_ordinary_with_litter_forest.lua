---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/woodsoils
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- generating of forest soils
local RaDiuS = {
--	WE1 NS1	   WE2 NS2     WE3 NS3
	{-1,-2,		-2,-2,		-2,-3},
	{ 0,-2,		-3,-1,		-3,-2},
	{ 1,-2,		-3, 0,		-4,-1},
	{-2,-1,		-3, 1,		-4, 0},
	{-1,-1,		-2, 2,		-4, 1},
	{ 0,-1,		-1, 3,		-3, 2},
	{ 1,-1,		 0, 3,		-2, 3},
	{ 2,-1,		 1, 3,		-1, 4},
	{-2, 0,		 2, 2,		 0, 4},
	{-1, 0,		 3, 1,		 1, 4},
	{ 0, 0,		 3, 0,		 2, 3},
	{ 1, 0,		 3,-1,		 3, 2},
	{ 2, 0,		 2,-2,		 4, 1},
	{-2, 1,		 1,-3,		 4, 0},
	{-1, 1,		 0,-3,		 4,-1},
	{ 0, 1,		-1,-3,		 3,-2},
	{ 1, 1,		 0, 0,		 2,-3},
	{ 2, 1,		 0, 0,		 1,-4},
	{-1, 2,		 0, 0,		 0,-4},
	{ 0, 2,		 0, 0,		-1,-4},
	{ 1, 2,		 0, 0,		 0, 0},
}
abstract_woodsoils.place_soil = function(pos)

	if minetest.get_item_group(minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name, "soil") > 0
	or minetest.get_item_group(minetest.get_node({x=pos.x,y=pos.y-2,z=pos.z}).name, "soil") > 0 then
		for i in pairs(RaDiuS) do
			local WE1 = RaDiuS[i][1]
			local NS1 = RaDiuS[i][2]
			local WE2 = RaDiuS[i][3]
			local NS2 = RaDiuS[i][4]
			local WE3 = RaDiuS[i][5]
			local NS3 = RaDiuS[i][6]
			local radius_1a = {x=pos.x+WE1,y=pos.y-1,z=pos.z+NS1}
			local radius_1b = {x=pos.x+WE1,y=pos.y-2,z=pos.z+NS1}
			local radius_2a = {x=pos.x+WE2,y=pos.y-1,z=pos.z+NS2}
			local radius_2b = {x=pos.x+WE2,y=pos.y-2,z=pos.z+NS2}
			local radius_3a = {x=pos.x+WE3,y=pos.y-1,z=pos.z+NS3}
			local radius_3b = {x=pos.x+WE3,y=pos.y-2,z=pos.z+NS3}
			--local node_1a = minetest.get_node(radius_1a)
			--local node_1b = minetest.get_node(radius_1b)
			local node_2a = minetest.get_node(radius_2a)
			local node_2b = minetest.get_node(radius_2b)
			local node_3a = minetest.get_node(radius_3a)
			local node_3b = minetest.get_node(radius_3b)
			-- Dirt with Leaves 1
			if minetest.get_item_group(minetest.get_node(radius_1a).name, "soil") > 0 then
				minetest.swap_node(radius_1a, {name="woodsoils:dirt_with_leaves_1"})
			end
			if minetest.get_item_group(minetest.get_node(radius_1b).name, "soil") > 0 then
				minetest.swap_node(radius_1b, {name="woodsoils:dirt_with_leaves_1"})
			end
			-- Grass with Leaves 2
			if string.find(node_2a.name, "dirt_with_grass") then
				minetest.swap_node(radius_2a, {name="woodsoils:grass_with_leaves_2"})
			end
			if string.find(node_2b.name, "dirt_with_grass") then
				minetest.swap_node(radius_2b, {name="woodsoils:grass_with_leaves_2"})
			end
			-- Grass with Leaves 1
			if string.find(node_3a.name, "dirt_with_grass") then
				minetest.swap_node(radius_3a, {name="woodsoils:grass_with_leaves_1"})
			end
			if string.find(node_3b.name, "dirt_with_grass") then
				minetest.swap_node(radius_3b, {name="woodsoils:grass_with_leaves_1"})
			end
		end
	end
end

minetest.register_node("woodsoils:dirt_with_leaves_1", {
    description = S("Forest Soil 1"),
    tiles = {
        "default_dirt.png^woodsoils_ground_cover.png",
        "default_dirt.png",
        "default_dirt.png^woodsoils_ground_cover_side.png"},
    is_ground_content = true,
    groups = {
        crumbly=3,
        soil=1--,
        --not_in_creative_inventory=1
    },
    drop = 'default:dirt',
    sounds = default.node_sound_dirt_defaults({
        footstep = {name="default_grass_footstep", gain=0.4},
    }),
    soil = {
        base = "woodsoils:dirt_with_leaves_1",
        dry = "farming:soil",
        wet = "farming:soil_wet"
    }
})

minetest.register_node("woodsoils:dirt_with_leaves_2", {
    description = S("Forest Soil 2"),
    tiles = {
        "woodsoils_ground.png",
        "default_dirt.png",
        "default_dirt.png^woodsoils_ground_side.png"},
    is_ground_content = true,
    groups = {
        crumbly=3,
        soil=1--,
        --not_in_creative_inventory=1
    },
    drop = 'default:dirt',
    sounds = default.node_sound_dirt_defaults({
        footstep = {name="default_grass_footstep", gain=0.4},
    }),
    soil = {
        base = "woodsoils:dirt_with_leaves_2",
        dry = "farming:soil",
        wet = "farming:soil_wet"
    }
})

minetest.register_node("woodsoils:grass_with_leaves_1", {
    description = S("Forest Soil 3"),
    tiles = {
        "default_grass.png^woodsoils_ground_cover2.png",
        "default_dirt.png",
        "default_dirt.png^default_grass_side.png^woodsoils_ground_cover_side2.png"},
    is_ground_content = true,
    groups = {
        crumbly=3,
        soil=1--,
        --not_in_creative_inventory=1
    },
    drop = 'default:dirt',
    sounds = default.node_sound_dirt_defaults({
        footstep = {name="default_grass_footstep", gain=0.4},
    }),
    soil = {
        base = "woodsoils:grass_with_leaves_1",
        dry = "farming:soil",
        wet = "farming:soil_wet"
    }
})

minetest.register_node("woodsoils:grass_with_leaves_2", {
    description = S("Forest Soil 4"),
    tiles = {
        "default_grass.png^woodsoils_ground_cover.png",
        "default_dirt.png",
        "default_dirt.png^default_grass_side.png^woodsoils_ground_cover_side.png"},
    is_ground_content = true,
    groups = {
        crumbly=3,
        soil=1--,
        --not_in_creative_inventory=1
    },
    drop = 'default:dirt',
    sounds = default.node_sound_dirt_defaults({
        footstep = {name="default_grass_footstep", gain=0.4},
    }),
    soil = {
        base = "woodsoils:grass_with_leaves_2",
        dry = "farming:soil",
        wet = "farming:soil_wet"
    }
})

if mod_woodsoils then
	sickles.register_cuttable("woodsoils:grass_with_leaves_1", "default:dirt", "default:dry_grass_1")
	sickles.register_cuttable("woodsoils:grass_with_leaves_2", "default:dirt", "default:dry_grass_1")
	sickles.register_cuttable("woodsoils:grass_with_leaves_1", "default:dirt", "default:grass_1")
	sickles.register_cuttable("woodsoils:grass_with_leaves_2", "default:dirt", "default:grass_1")
end
]]--
