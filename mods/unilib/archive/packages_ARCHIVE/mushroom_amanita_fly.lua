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
minetest.register_node("nsspf:amanita_muscaria", {
	description = "Amanita muscaria",
	drawtype = "mesh",
	mesh = "amanita.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"amanita_muscaria.png"},
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	groups = {snappy=3},
	on_use = minetest.item_eat(-20),
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

minetest.register_node("nsspf:cooked_amanita_muscaria", {
	description = "Cooked Amanita muscaria",
	drawtype = "mesh",
	mesh = "amanita.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_amanita_muscaria.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-18),
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

nsspf_register_recipes ('amanita_muscaria')
]]--
