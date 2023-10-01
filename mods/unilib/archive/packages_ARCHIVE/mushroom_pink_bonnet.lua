---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("nsspf:marasmius_haematocephalus", {
	description = "Marasmius haematocephalus",
	drawtype = "mesh",
	mesh = "marasmius_haematocephalus.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"marasmius_haematocephalus.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-1),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1}, 
      },
})

minetest.register_node("nsspf:cooked_marasmius_haematocephalus", {
	description = "Cooked Marasmius haematocephalus",
	drawtype = "mesh",
	mesh = "marasmius_haematocephalus.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_marasmius_haematocephalus.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-19),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.1, -0.49, -0.1, 0.1, -0.1, 0.1}, 
      },
})

function nsspf_register_recipes (name)

minetest.register_craft({
	type = "cooking",
	output = "nsspf:cooked_"..name,
	recipe = "nsspf:"..name,
	cooktime = 10,
})

end

nsspf_register_recipes ('marasmius_haematocephalus')

minetest.register_abm({
	nodenames = {"default:jungletree"},
	neighbors = {"air"},
	interval = 180.0,
	chance = 600,
	action = function(pos, node)
		local pos1 = {x=pos.x, y=pos.y+1, z=pos.z}
		local n = minetest.env:get_node(pos1).name
		if n == 'air' then
			minetest.set_node({x = pos.x, y = pos.y+1, z = pos.z}, {name = "nsspf:marasmius_haematocephalus"})
			minetest.get_node_timer(pos):start(300)
		end
	end
})

]]--
