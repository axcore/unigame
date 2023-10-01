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
minetest.register_node("nsspf:boletus_pinophilus", {
	description = "Boletus pinophilus",
	drawtype = "mesh",
	mesh = "boletus.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"boletus_pinophilus.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(2),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28}, 
      },
})

minetest.register_node("nsspf:cooked_boletus_pinophilus", {
	description = "Cooked Boletus pinophilus",
	drawtype = "mesh",
	mesh = "boletus.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"cooked_boletus_pinophilus.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(16),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.28, -0.49, -0.28, 0.28, 0.06, 0.28}, 
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

nsspf_register_recipes ('boletus_pinophilus')
]]--
