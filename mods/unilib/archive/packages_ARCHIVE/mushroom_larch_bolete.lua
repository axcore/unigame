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
minetest.register_node("nsspf:suillus_grevillei", {
	description = "Suillus grevillei",
	drawtype = "mesh",
	mesh = "suillus_grevillei.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"suillus_grevillei.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(1),
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

minetest.register_node("nsspf:cooked_suillus_grevillei", {
	description = "Cooked Suillus grevillei",
	drawtype = "mesh",
	mesh = "suillus_grevillei.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_suillus_grevillei.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(10),
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

nsspf_register_recipes ('suillus_grevillei')
]]--
