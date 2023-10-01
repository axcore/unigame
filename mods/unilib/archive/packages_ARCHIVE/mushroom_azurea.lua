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
minetest.register_node("nsspf:clitocybula_azurea", {
	description = "Clitocybula_azurea",
	drawtype = "mesh",
	mesh = "clitocybula_azurea.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"clitocybula_azurea.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-6),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5}, 
      },
})

minetest.register_node("nsspf:cooked_clitocybula_azurea", {
	description = "Cooked Clitocybula_azurea",
	drawtype = "mesh",
	mesh = "clitocybula_azurea.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_clitocybula_azurea.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(10),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5}, 
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

nsspf_register_recipes ('clitocybula_azurea')

nssbf_register_saprotrophicontrees ('clitocybula_azurea', 'Clitocybula azurea', 'default:jungletree', 12, 28)
]]--
