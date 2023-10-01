---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/trunks
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function check_node_buildable_to(pos)
	local node = minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]
	if def then
		return def.buildable_to
	end
end

abstract_trunks.place_twig = function(pos)
	local twig_size     = math.random(1,27)

	local right_here    = {x=pos.x  , y=pos.y+1, z=pos.z  }
	local north         = {x=pos.x  , y=pos.y+1, z=pos.z+1}
	local north_east    = {x=pos.x+1, y=pos.y+1, z=pos.z+1}
	local east          = {x=pos.x+1, y=pos.y+1, z=pos.z  }
	local south_east    = {x=pos.x+1, y=pos.y+1, z=pos.z-1}
	local south         = {x=pos.x  , y=pos.y+1, z=pos.z-1}
	local south_west    = {x=pos.x-1, y=pos.y+1, z=pos.z-1}
	local west          = {x=pos.x-1, y=pos.y+1, z=pos.z  }
	local north_west    = {x=pos.x-1, y=pos.y+1, z=pos.z+1}

--	small twigs
	if twig_size <= 16 then
		minetest.swap_node(right_here, {name="trunks:twig_"..math.random(1,4), param2=math.random(0,3)})
	end
--	big twigs
	if Big_Twigs == true then
--	big twig 1
	if twig_size == 17 then
		if not (check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z+1})
			or check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_5"})
			end
			if check_node_buildable_to(north_east) then
				minetest.swap_node(north_east, {name="trunks:twig_7"})
			end
			if check_node_buildable_to(east) then
				minetest.swap_node(east,		  {name="trunks:twig_8"})
			end
		end
	elseif twig_size == 18 then
		if not (check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z-1})
			or check_node_buildable_to({x=pos.x,y=pos.y,z=pos.z-1})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_5", param2=1})
			end
			if check_node_buildable_to(south_east) then
				minetest.swap_node(south_east, {name="trunks:twig_7", param2=1})
			end
			if check_node_buildable_to(south) then
				minetest.swap_node(south,	  {name="trunks:twig_8", param2=1})
			end
		end
	elseif twig_size == 19 then
		if not (check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z-1})
			or check_node_buildable_to({x=pos.x-1,y=pos.y,z=pos.z})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_5", param2=2})
			end
			if check_node_buildable_to(south_west) then
				minetest.swap_node(south_west, {name="trunks:twig_7", param2=2})
			end
			if check_node_buildable_to(west) then
				minetest.swap_node(west,		  {name="trunks:twig_8", param2=2})
			end
		end
	elseif twig_size == 20 then
		if not (check_node_buildable_to({x=pos.x-1,y=pos.y,z=pos.z+1})
			or check_node_buildable_to({x=pos.x,y=pos.y,z=pos.z+1})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_5", param2=3})
			end
			if check_node_buildable_to(north_west) then
				minetest.swap_node(north_west, {name="trunks:twig_7", param2=3})
			end
			if check_node_buildable_to(north) then
				minetest.swap_node(north,	  {name="trunks:twig_8", param2=3})
			end
		end
--	big twig 2
	elseif twig_size == 21 then
		if not (check_node_buildable_to({x=pos.x,y=pos.y,z=pos.z+1})
			or check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z+1})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_9"})
			end
			if check_node_buildable_to(north) then
				minetest.swap_node(north,	  {name="trunks:twig_10"})
			end
			if check_node_buildable_to(north_east) then
				minetest.swap_node(north_east, {name="trunks:twig_11"})
			end
		end
	elseif twig_size == 22 then
		if not (check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z})
			or check_node_buildable_to({x=pos.x+1,y=pos.y,z=pos.z-1})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_9", param2=1})
			end
			if check_node_buildable_to(east) then
				minetest.swap_node(east,		  {name="trunks:twig_10", param2=1})
			end
			if check_node_buildable_to(south_east) then
				minetest.swap_node(south_east, {name="trunks:twig_11", param2=1})
			end
		end
	elseif twig_size == 23 then
		if not (check_node_buildable_to({x=pos.x,y=pos.y,z=pos.z-1})
			or check_node_buildable_to({x=pos.x-1,y=pos.y,z=pos.z-1})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_9", param2=2})
			end
			if check_node_buildable_to(south) then
				minetest.swap_node(south,	  {name="trunks:twig_10", param2=2})
			end
			if check_node_buildable_to(south_west) then
				minetest.swap_node(south_west, {name="trunks:twig_11", param2=2})
			end
		end
	elseif twig_size == 24 then
		if not (check_node_buildable_to({x=pos.x-1,y=pos.y,z=pos.z})
			or check_node_buildable_to({x=pos.x-1,y=pos.y,z=pos.z+1})) then

			if check_node_buildable_to(right_here) then
				minetest.swap_node(right_here, {name="trunks:twig_9", param2=3})
			end
			if check_node_buildable_to(west) then
				minetest.swap_node(west,		  {name="trunks:twig_10", param2=3})
			end
			if check_node_buildable_to(north_west) then
				minetest.swap_node(north_west, {name="trunks:twig_11", param2=3})
			end
		end
	elseif twig_size <= 25 then
		minetest.swap_node(right_here, {name="trunks:twig_"..math.random(12,13), param2=math.random(0,3)})
	end
	end
end

local flat_stick = {-1/2, -1/2, -1/2, 1/2, -7/16, 1/2}
local NoDe = { {1}, {2}, {3}, {4}, {5}, {7}, {8}, {9}, {10}, {11}, {12}, {13} }

for i in pairs(NoDe) do
    local NR = NoDe[i][1]
    local iNV = NR - 1
    minetest.register_node("trunks:twig_"..NR, {
        description = S("Twig"),
        inventory_image = "trunks_twig_"..NR..".png",
        wield_image = "trunks_twig_"..NR..".png",
        drawtype = "nodebox",
        tiles = {
            "trunks_twig_"..NR..".png",
            "trunks_twig_"..NR..".png^[transformFY", -- mirror
            "trunks_twig_6.png" -- empty
        },
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = false,
        sunlight_propagates = true,
        buildable_to = true,
        node_box = {type = "fixed", fixed = flat_stick},
        groups = {
            choppy=2,
            oddly_breakable_by_hand=2,
            flammable=3,
            attached_node=1,
            not_in_creative_inventory=iNV
        },
        drop = "trunks:twig_1",
        sounds = default.node_sound_leaves_defaults(),
        liquids_pointable = true,
        on_place = function(itemstack, placer, pointed_thing)
            local pt = pointed_thing

            if not placer then return end
            local playername = placer:get_player_name()
            if minetest.is_protected(pt.above, playername) then 
                minetest.record_protection_violation(pt.above, playername)
                return
            end

            local direction = minetest.dir_to_facedir(placer:get_look_dir())
            if minetest.get_node(pt.above).name=="air" then
                minetest.swap_node(pt.above, {name="trunks:twig_"..math.random(1,4), param2=direction})
                if not minetest.setting_getbool("creative_mode") then
                    itemstack:take_item()
                end
                return itemstack
            end
        end,
    })
end

minetest.register_craft({ -- *leaves --> twigs
    output = "trunks:twig_1 2",
    recipe = {{"group:leafdecay"}}
})
if minetest.get_modpath("moretrees") ~= nil then
    minetest.register_craft({ -- moretrees_leaves --> twigs
        output = "trunks:twig_1 2",
        recipe = {{"group:moretrees_leaves"}}
    })
    minetest.register_craft({ -- except moretrees:palm_leaves
        output = "moretrees:palm_leaves",
        recipe = {{"moretrees:palm_leaves"}}
    })
end
if minetest.get_modpath("bushes") ~= nil then
    minetest.register_craft({ -- BushLeaves --> twigs
        output = "trunks:twig_1 2",
        recipe = {{"bushes:BushLeaves1"}}
    })
    minetest.register_craft({ -- bushbranches --> twigs
        output = "trunks:twig_1 4",
        recipe = {{"bushes:bushbranches1"}}
    })
    minetest.register_craft({
        output = "trunks:twig_1 4",
        recipe = {{"bushes:bushbranches2"}}
    })
    minetest.register_craft({
        output = "trunks:twig_1 2",
        recipe = {{"bushes:BushLeaves2"}}
    })
    minetest.register_craft({
        output = "trunks:twig_1 4",
        recipe = {{"bushes:bushbranches2"}}
    })
    minetest.register_craft({
        output = "trunks:twig_1 4",
        recipe = {{"bushes:bushbranches3"}}
    })
end
minetest.register_craft({ -- twig --> stick
    output = "default:stick",
    recipe = {{"trunks:twig_1"}}
})

minetest.register_node("trunks:twigs", {
    description = S("Twigs Block"),
    paramtype2 = "facedir",
    tiles = {"trunks_twigs.png"},
    groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
    sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({ -- twigs --> twigs block
    output = "trunks:twigs",
    recipe = {
        {"trunks:twig_1","trunks:twig_1","trunks:twig_1"},
        {"trunks:twig_1",      ""       ,"trunks:twig_1"},
        {"trunks:twig_1","trunks:twig_1","trunks:twig_1"},
    }
})
minetest.register_craft({ -- twigs block --> twigs
    output = "trunks:twig_1 8",
    recipe = {{"trunks:twigs"}}
})

minetest.register_craft({ -- twigs blocks --> twigs_slabs
    output = "trunks:twigs_slab 6",
    recipe = {
        {"trunks:twigs","trunks:twigs","trunks:twigs"},
    }
})

minetest.register_craft({ -- twigs blocks --> twigs_roofs
    output = "trunks:twigs_roof 4",
    recipe = {
        {"trunks:twigs",""},
        {"","trunks:twigs"},
    }
})
minetest.register_craft({
    output = "trunks:twigs_roof 4",
    recipe = {
        {"","trunks:twigs"},
        {"trunks:twigs",""},
    }
})

minetest.register_craft({ -- twigs blocks --> twigs_roof_corners
    output = "trunks:twigs_roof_corner 8",
    recipe = {
        {      ""      ,"trunks:twigs",      ""      },
        {"trunks:twigs",      ""      ,"trunks:twigs"},
    }
})

minetest.register_craft({ -- twigs blocks --> twigs_roof_corner_2's
    output = "trunks:twigs_roof_corner_2 8",
    recipe = {
        {"trunks:twigs",      ""      ,"trunks:twigs"},
        {      ""      ,"trunks:twigs",      ""      },
    }
})

if Twigs_on_ground == true then
biome_lib.register_on_generate({
    surface = {"default:dirt_with_grass"},
    max_count = Twigs_on_ground_Max_Count,
    rarity = Twigs_on_ground_Rarity,
    min_elevation = 1,
    max_elevation = 40,
    near_nodes = {"group:tree","ferns:fern_03","ferns:fern_02","ferns:fern_01"},
    near_nodes_size = 3,
    near_nodes_vertical = 1,
    near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.place_twig
)
end

if Twigs_on_water == true then
biome_lib.register_on_generate({
    surface = {"default:water_source"},
    max_count = Twigs_on_water_Max_Count,
    rarity = Twigs_on_water_Rarity,
    min_elevation = 1,
    max_elevation = 40,
    near_nodes = {"group:tree"},
    near_nodes_size = 3,
    near_nodes_vertical = 1,
    near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.place_twig
)
]]--
