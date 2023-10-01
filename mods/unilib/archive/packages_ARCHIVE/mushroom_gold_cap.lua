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
minetest.register_node("nsspf:psilocybe_cubensis", {
	description = "Psilocybe cubensis",
	drawtype = "mesh",
	mesh = "psilocybe_cubensis.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"psilocybe_cubensis.png"},
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	groups = {snappy=3},
	on_use = minetest.item_eat(-7),
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

minetest.register_node("nsspf:cooked_psilocybe_cubensis", {
	description = "Cooked Psilocybe cubensis",
	drawtype = "mesh",
	mesh = "psilocybe_cubensis.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_psilocybe_cubensis.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(2),
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

nsspf_register_recipes ('psilocybe_cubensis')

nsspf_register_saprotrophicground ('psilocybe_cubensis','Psilocybe cubensis', 20, 16, 12)
]]--
