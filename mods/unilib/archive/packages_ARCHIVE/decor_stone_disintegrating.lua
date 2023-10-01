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
minetest.register_node("decoblocks:crumblestone", {
	description = "Crumbly Stone",
	tiles = {"decoblocks_crumblestone.png"},
	groups = {crumbly = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "shapeless",
	output = 'decoblocks:crumblestone 2',
	recipe = {
		'decoblocks:old_stone_tiles',
		"default:cobble",
		'decoblocks:old_stone_tiles',
	}
})

minetest.register_abm({
	nodenames = {"decoblocks:crumblestone"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local objs = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+0.5, z=pos.z}, 0.5)
		for _, obj in ipairs(objs) do
			if obj:is_player() then
			minetest.add_particlespawner({
			amount = 13,
			time = 1,
			minpos = {x=pos.x-0.2, y=pos.y, z=pos.z-0.2},
			maxpos = {x=pos.x+0.2, y=pos.y+1, z=pos.z+0.2},
			minvel = {x=-0.1, y=-1, z=-0.1},
			maxvel = {x=0.1, y=-2, z=0.1},
			minacc = {x=0, y=-0.5, z=0},
			maxacc = {x=0, y=-1, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 1,
			maxsize = 2,
			collisiondetection = true,
			texture = "default_stone.png"
			})
				minetest.set_node(pos, {name = "air"})

			end
		end
	end
})
]]--
