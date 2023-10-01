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
minetest.register_node("underch:lava_crack", {
	description = "Lava Crack",
	tiles = {"underch_omphyrite.png^underch_lava_crack.png"},
	groups = {cracky = 3},
	drop = 'underch:omphyrite_cobble',
	legacy_mineral = true,
	light_source = 12,
	sounds = default.node_sound_stone_defaults(),
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.place_node(pos, {name="default:lava_source"}, digger)
	end
})
]]--
