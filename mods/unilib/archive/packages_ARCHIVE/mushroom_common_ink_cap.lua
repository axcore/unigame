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
minetest.register_node("nsspf:coprinus_atramentarius", {
	description = "Coprinus atramentarius",
	drawtype = "mesh",
	mesh = "coprinus_atramentarius.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"coprinus_atramentarius.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-13),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05}, 
      },
})

minetest.register_node("nsspf:cooked_coprinus_atramentarius", {
	description = "Cooked Coprinus atramentarius",
	drawtype = "mesh",
	mesh = "coprinus_atramentarius.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_coprinus_atramentarius.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(6),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0, 0.05}, 
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

nsspf_register_recipes ('coprinus_atramentarius')

nsspf_register_saprotrophicground ('coprinus_atramentarius','Coprinus atramentarius', 16, 16, 6)
]]--
