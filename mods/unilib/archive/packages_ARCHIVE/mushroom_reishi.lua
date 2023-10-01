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
minetest.register_node("nsspf:ganoderma_lucidum", {
	description = "Ganoderma lucidum",
	drawtype = "mesh",
	mesh = "fistulina_hepatica.b3d",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"ganoderma_lucidum.png"},
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

minetest.register_node("nsspf:cooked_ganoderma_lucidum", {
	description = "Cooked Ganoderma lucidum",
	drawtype = "mesh",
	mesh = "fistulina_hepatica.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_ganoderma_lucidum.png"},
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

function nsspf_register_recipes (name)

minetest.register_craft({
	type = "cooking",
	output = "nsspf:cooked_"..name,
	recipe = "nsspf:"..name,
	cooktime = 10,
})

end

nsspf_register_recipes ('ganoderma_lucidum')

nssbf_register_saprotrophicontrees ('ganoderma_lucidum', 'Ganoderma lucidum', 'default:jungletree', 14, 28)
]]--
