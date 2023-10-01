---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("caverealms:stone_with_lichen", {
	description = "Cave Stone with Lichen",
	tiles = {"default_cobble.png^caverealms_lichen.png", "default_cobble.png", "default_cobble.png^caverealms_lichen_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})
if mod_caverealms then
	sickles.register_cuttable("caverealms:stone_with_lichen", "default:cobble", "sickles:moss_purple")
end
]]--
