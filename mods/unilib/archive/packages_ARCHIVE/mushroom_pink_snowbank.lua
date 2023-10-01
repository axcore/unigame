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
minetest.register_node("nsspf:hygrophorus_goetzii", {
	description = "Hygrophorus goetzii",
	drawtype = "mesh",
	mesh = "hygrophorus_goetzii.b3d",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"hygrophorus_goetzii.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-4),
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

minetest.register_node("nsspf:cooked_hygrophorus_goetzii", {
	description = "Cooked Hygrophorus goetzii",
	drawtype = "mesh",
	mesh = "hygrophorus_goetzii.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_hygrophorus_goetzii.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(8),
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

nsspf_register_recipes ('hygrophorus_goetzii')
]]--
