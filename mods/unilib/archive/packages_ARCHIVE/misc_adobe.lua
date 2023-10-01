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
minetest.register_node("darkage:adobe", {
	description = "Adobe",
	tiles = {"darkage_adobe.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})
minetest.register_craft({
	output = "darkage:adobe 4",
	recipe = {
		{"default:sand",		"default:sand"},
		{"default:clay_lump",	"farming:straw"},
	}
})
]]--
