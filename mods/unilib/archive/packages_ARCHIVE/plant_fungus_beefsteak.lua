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
minetest.register_node("nsspf:fistulina_hepatica", {
	description = "Fistulina hepatica",
	drawtype = "mesh",
	mesh = "fistulina_hepatica.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"fistulina_hepatica.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(4),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5}, 
      },
})

minetest.register_node("nsspf:cooked_fistulina_hepatica", {
	description = "Cooked Fistulina hepatica",
	drawtype = "mesh",
	mesh = "fistulina_hepatica.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_fistulina_hepatica.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(14),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5}, 
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

nsspf_register_recipes ('fistulina_hepatica')

nssbf_register_saprotrophicontrees ('fistulina_hepatica', 'Fistulina hepatica', 'default:pine_tree', 16, 24)
]]--
