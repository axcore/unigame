---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local additional_fachwerk_types = false

minetest.register_node("fachwerk:framed_glass", {
	description = "Timber-framed Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"fachwerk_blank.png^default_glass_detail.png", "default_glass_detail.png"},
	inventory_image = minetest.inventorycube("fachwerk_blank.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3,oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
]]--
