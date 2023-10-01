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
minetest.register_node("nsspf:armillaria_mellea", {
	description = "Armillaria mellea",
	drawtype = "mesh",
	mesh = "armillaria_mellea.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"armillaria_mellea.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(2),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5}, 
      },
})

minetest.register_node("nsspf:cooked_armillaria_mellea", {
	description = "Cooked Armillaria mellea",
	drawtype = "mesh",
	mesh = "armillaria_mellea.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_armillaria_mellea.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(12),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5}, 
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

nsspf_register_recipes ('armillaria_mellea')

nssbf_register_saprotrophicontrees ('armillaria_mellea', 'Armillaria mellea', 'default:tree', 16, 24)
]]--
