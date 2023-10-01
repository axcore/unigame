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
minetest.register_node("nsspf:clitocybe_glacialis", {
	description = "Clitocybe glacialis",
	drawtype = "mesh",
	mesh = "clitocybe_glacialis.b3d",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"clitocybe_glacialis.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(1),
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

minetest.register_node("nsspf:cooked_clitocybe_glacialis", {
	description = "Cooked Clitocybe glacialis",
	drawtype = "mesh",
	mesh = "clitocybe_glacialis.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_clitocybe_glacialis.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(10),
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

nsspf_register_recipes ('clitocybe_glacialis')
]]--
