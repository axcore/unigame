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
minetest.register_node("nsspf:macrolepiota_procera", {
	description = "Macrolepiota procera",
	drawtype = "mesh",
	mesh = "macrolepiota_procera.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"macrolepiota_procera.png"},
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	groups = {snappy=3},
	on_use = minetest.item_eat(3),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05}, 
      },
})

minetest.register_node("nsspf:cooked_macrolepiota_procera", {
	description = "Cooked Macrolepiota procera",
	drawtype = "mesh",
	mesh = "macrolepiota_procera.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_macrolepiota_procera.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(16),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.05, -0.49, -0.05, 0.05, 0.2, 0.05}, 
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

nsspf_register_recipes ('macrolepiota_procera')

nsspf_register_saprotrophicground ('macrolepiota_procera','Macrolepiota procera', 10, 12, 10)
]]--
