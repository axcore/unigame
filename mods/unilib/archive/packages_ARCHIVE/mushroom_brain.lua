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
minetest.register_node("nsspf:gyromitra_esculenta", {
	description = "Gyromitra esculenta",
	drawtype = "mesh",
	mesh = "gyromitra_esculenta.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"gyromitra_esculenta.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-20),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, -0.2, 0.05}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, -0.2, 0.05}, 
      },
})

minetest.register_node("nsspf:cooked_gyromitra_esculenta", {
	description = "Cooked Gyromitra esculenta",
	drawtype = "mesh",
	mesh = "gyromitra_esculenta.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_gyromitra_esculenta.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-16),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, -0.2, 0.05}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, -0.2, 0.05}, 
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

nsspf_register_recipes ('gyromitra_esculenta')

nsspf_register_saprotrophicground ('gyromitra_esculenta','Gyromitra esculenta', 12, 14, 8)
]]--
