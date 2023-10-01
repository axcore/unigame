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
minetest.register_node("nsspf:morchella_conica", {
	description = "Morchella conica",
	drawtype = "mesh",
	mesh = "morchella_conica.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"morchella_conica.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(2),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15}, 
      },
})

minetest.register_node("nsspf:cooked_morchella_conica", {
	description = "Cooked Morchella conica",
	drawtype = "mesh",
	mesh = "morchella_conica.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_morchella_conica.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(8),
	on_place = function(itemstack, placer, pointed_thing)
		return
	end,
	selection_box = {
      type = "fixed",
      fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.15, -0.49, -0.15, 0.15, 0.06, 0.15}, 
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

nsspf_register_recipes ('morchella_conica')
]]--
