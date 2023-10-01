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
minetest.register_node("nsspf:panellus_pusillus", {
	description = "Panellus pusillus",
	drawtype = "mesh",
	mesh = "panellus_pusillus.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"panellus_pusillus.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-2),
	selection_box = {
      type = "fixed",
      fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5}, 
      },
   collision_box = {
      type = "fixed",
      fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5}, 
      },
})

minetest.register_node("nsspf:cooked_panellus_pusillus", {
	description = "Cooked Panellus pusillus",
	drawtype = "mesh",
	mesh = "panellus_pusillus.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_panellus_pusillus.png"},
	groups = {snappy=3},
	on_use = minetest.item_eat(-4),
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

minetest.register_node("nsspf:panellus_pusillus_light", {
	description = "Nocturn Panellus pusillus",
	drawtype = "mesh",
	mesh = "panellus_pusillus.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"panellus_pusillus_light.png"},
	groups = {snappy=3, not_in_creative_inventory=1},
	light_source = 8,
	drop = "nsspf:panellus_pusillus",
	on_use = minetest.item_eat(-2),
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

nsspf_register_recipes ('panellus_pusillus')

nssbf_register_saprotrophicontrees ('panellus_pusillus', 'Panellus pusillus', 'default:tree', 23, 37)

local OPEN_TIME_START = 0.2
local OPEN_TIME_END = 0.8
local OPEN_CHECK = 10

set_fluor = function (pos)
	if (minetest.get_node_light(pos, nil) < 10) and ((minetest.get_timeofday() < 19500) or (minetest.get_timeofday() > 5000)) then
		minetest.env:add_node(pos, { name = "nsspf:panellus_pusillus_light" })
	else
		minetest.env:add_node(pos, { name = "nsspf:panellus_pusillus" })
	end
end

minetest.register_abm({
	nodenames = { "nsspf:panellus_pusillus", "nsspf:panellus_pusillus_light" },
	interval = OPEN_CHECK,
	chance = 1,

	action = function(pos, node, active_object_count, active_object_count_wider)
		set_fluor(pos)
	end
})
]]--
