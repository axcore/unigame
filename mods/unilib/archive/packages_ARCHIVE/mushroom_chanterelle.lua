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
minetest.register_node("nsspf:cantharellus_cibarius", {
	description = "Cantharellus cibarius",
	drawtype = "mesh",
	mesh = "cantharellus_cibarius.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	tiles = {"cantharellus_cibarius.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(1),
	selection_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28}, 
      },
})

minetest.register_node("nsspf:cooked_cantharellus_cibarius", {
	description = "Cooked Cantharellus cibarius",
	drawtype = "mesh",
	mesh = "cantharellus_cibarius.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_cantharellus_cibarius.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(8),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, -0.26, 0.28}, 
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

nsspf_register_recipes ('cantharellus_cibarius')
]]--
