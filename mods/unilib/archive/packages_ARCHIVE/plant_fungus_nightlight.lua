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
minetest.register_node("nsspf:mycena_chlorophos", {
	description = "Mycena chlorophos",
	drawtype = "mesh",
	mesh = "mycena_chlorophos.b3d",
    paramtype = "light",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
    paramtype2 = "facedir",
	tiles = {"mycena_chlorophos.png"},
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

minetest.register_node("nsspf:cooked_mycena_chlorophos", {
	description = "Cooked Mycena chlorophos",
	drawtype = "mesh",
	mesh = "mycena_chlorophos.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	tiles = {"cooked_mycena_chlorophos.png"},
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

minetest.register_node("nsspf:mycena_chlorophos_light", {
	description = "Nocturn Mycena chlorophos",
	drawtype = "mesh",
	mesh = "mycena_chlorophos.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="air"})
	end,
	tiles = {"mycena_chlorophos_light.png"},
	groups = {snappy=3, not_in_creative_inventory=1},
	light_source = 8,
	drop ="nsspf:mycena_chlorophos",
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

nsspf_register_recipes ('mycena_chlorophos')

nssbf_register_saprotrophicontrees ('mycena_chlorophos', 'Mycena clorophos', 'default:dirt', 30, 43)

local OPEN_TIME_START = 0.2
local OPEN_TIME_END = 0.8
local OPEN_CHECK = 10

set_fluo = function (pos)
	if (minetest.get_node_light(pos, nil) < 10) and ((minetest.get_timeofday() < 19500) or (minetest.get_timeofday() > 5000)) then
		minetest.add_node(pos, { name = "nsspf:mycena_chlorophos_light" })
	else
		minetest.add_node(pos, { name = "nsspf:mycena_chlorophos" })
	end
end

minetest.register_abm({
	nodenames = { "nsspf:mycena_chlorophos", "nsspf:mycena_chlorophos_light"},
	interval = OPEN_CHECK,
	chance = 1,

	action = function(pos, node, active_object_count, active_object_count_wider)
		set_fluo(pos)
	end
})
]]--
