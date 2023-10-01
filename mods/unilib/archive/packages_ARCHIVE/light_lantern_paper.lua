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
minetest.register_node("decoblocks:paper_lantern", {
	description = "Paper Lantern",
	tiles = {"decoblocks_paper_lantern_top.png", "decoblocks_paper_lantern_top.png", "decoblocks_paper_lantern.png"},
	paramtype = "light",
	light_source = 13,
	is_ground_content = false,
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
				flammable = 3, wool = 1},
		sounds = default.node_sound_defaults(),
})
minetest.register_craft({
	output = 'decoblocks:paper_lantern',
	recipe = {
		{'group:wood', 'default:paper', 'group:wood'},
		{'default:paper', 'default:torch', 'default:paper'},
		{'group:wood', 'default:paper', 'group:wood'},
	}
})

minetest.register_abm({
	nodenames = {"decoblocks:paper_lantern"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 25,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "decoblocks_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 2.00},
			glow = 9
		})
	end
})
]]--
