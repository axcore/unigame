---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:stalagmite0", {
	description = "Stalagmite",
	drawtype = "plantlike",
	tiles = {"mapgen_stalagmite0.png^[transformFY"},
	inventory_image = "mapgen_stalagmite0.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagmite1", {
	description = "Stalagmite",
	drawtype = "plantlike",
	visual_scale = 2,
	tiles = {"mapgen_stalagmite3.png^[transformFY"},
	inventory_image = "mapgen_stalagmite3.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagmite2", {
	description = "Stalagmite",
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"mapgen_stalagmite2.png^[transformFY"},
	inventory_image = "mapgen_stalagmite2.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_on_generated(function(minp, maxp)
	if maxp.y < -1000 or maxp.y > 20 then
		return
	end
	local dirt = minetest.find_nodes_in_area(minp, maxp,
		{"default:stone"})
	for n = 1, #dirt do
		if math.random(1, 50) == 1 then
			local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
				if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" and pos.y >= -100 then
					if math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:stalagmite0"})
					elseif math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:stalagmite1"})
					else
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "mapgen:stalagmite2"})
					end
				end
		end
	end
end)
]]--
