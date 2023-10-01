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
minetest.register_node("darkage:chalked_bricks", {
	description = "Chalked Brick",
	tiles = {"darkage_chalked_bricks.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "darkage:chalked_bricks 4",
	recipe = {
		{"default:stone", 			"default:stone",		"darkage:chalk_powder"},
		{"darkage:chalk_powder",	"darkage:chalk_powder", "darkage:chalk_powder"},
		{"default:stone",			"darkage:chalk_powder", "default:stone"},
	}
})
]]--
