---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:darkdirt", {
	description = "Dark Dirt",
	tiles = {"darkage_darkdirt.png"},
	is_ground_content = false,
	groups = {crumbly=2, not_cuttable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = "darkage:darkdirt 4",
	recipe = {
		{"default:dirt",	"default:dirt"},
		{"default:gravel",	"default:gravel"},
	}
})
]]--
