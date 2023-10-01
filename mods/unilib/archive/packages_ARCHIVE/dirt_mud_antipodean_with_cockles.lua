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
minetest.register_node("aotearoa:mud_with_cockles", {
	description = "Mud with Cockles",
	tiles = {"aotearoa_mud_with_cockles.png"},
	groups = {crumbly = 3, puts_out_fire = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
	--dig up the shellfish
	on_punch = function(pos, node, puncher)
		puncher:get_inventory():add_item('main', "aotearoa:cockle")
		minetest.set_node(pos, {name = "aotearoa:mud"})
	end,
})
]]--
