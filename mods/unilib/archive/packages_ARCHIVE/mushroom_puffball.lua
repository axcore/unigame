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
minetest.register_node("nsspf:lycoperdon_pyriforme", {
	description = "Lycoperdon pyriforme",
	drawtype = "mesh",
	mesh = "lycoperdon_pyriforme.b3d",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"lycoperdon_pyriforme.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(8),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3}, 
      },
})

minetest.register_node("nsspf:cooked_lycoperdon_pyriforme", {
	description = "Cooked Lycoperdon pyriforme",
	drawtype = "mesh",
	mesh = "lycoperdon_pyriforme.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_lycoperdon_pyriforme.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(12),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.3, -0.49, -0.3, 0.3, -0.3, 0.3}, 
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

nsspf_register_recipes ('lycoperdon_pyriforme')

nsspf_register_saprotrophicground ('lycoperdon_pyriforme','Lycoperdon piriforme',10, 10, 8)
]]--
