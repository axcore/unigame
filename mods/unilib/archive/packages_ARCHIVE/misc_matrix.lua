---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:bulk", {
	description = "O_O",
	tiles = {"underch_bulk.png"},
	groups = {jit_shadow = 1},
	is_ground_content = true,
	drop = {},
	diggable = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		underch.jit.reveal(pos, true, false)
	end,
	after_dig_node = underch.jit.dig_shadow,
})

minetest.register_node("underch:crust", {
	description = "o_O",
	tiles = {"underch_crust.png"},
	groups = {jit_shadow = 1},
	is_ground_content = true,
	drop = {},
	diggable = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		underch.jit.reveal(pos, true, false)
	end,
	after_dig_node = underch.jit.dig_shadow,
})
]]--
