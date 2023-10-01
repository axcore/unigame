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
minetest.register_node("nsspf:fomes_fomentarius", {
	description = "Fomes fomentarius",
	drawtype = "mesh",
	mesh = "fomes_fomentarius.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"fomes_fomentarius.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-1),
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

nssbf_register_saprotrophicontrees ('fomes_fomentarius', 'Fomes fomentarius', 'default:aspen_tree', 13, 18)
]]--
