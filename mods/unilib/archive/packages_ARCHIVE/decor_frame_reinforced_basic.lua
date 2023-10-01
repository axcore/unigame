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
darkage.register_reinforce("Wood", "default:wood", {
	tiles = {"default_wood.png"},
	groups = {snappy=2, choppy=3, flammable=3},
	sounds = default.node_sound_wood_defaults()
})

darkage.register_reinforce("Chalk", "darkage:chalk_powder", {
	tiles = {"darkage_chalk.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

darkage.register_reinforce("Chalked Bricks", "darkage:chalked_bricks", {
	tiles = {"darkage_chalked_bricks.png"},
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
]]--
