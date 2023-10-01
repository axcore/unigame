---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("aotearoa:iron_sand_with_pipi", {
	description = "Iron-sand with Pipi",
	tiles = {"aotearoa_iron_sand_with_pipi.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
	--dig up the shellfish
	on_punch = function(pos, node, puncher)
		puncher:get_inventory():add_item('main', "aotearoa:pipi")
		minetest.set_node(pos, {name = "aotearoa:iron_sand"})
	end,
})
]]--
