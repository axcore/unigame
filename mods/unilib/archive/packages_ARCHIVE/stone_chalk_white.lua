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
minetest.register_node("darkage:chalk", {
	description = "Chalk",
	tiles = {"darkage_chalk.png"},
	is_ground_content = true,
	drop = 'darkage:chalk_powder 2',
	groups = {crumbly=2, cracky=2, not_cuttable=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craftitem("darkage:chalk_powder", {
	description = "Chalk Powder",
	inventory_image = "darkage_chalk_powder.png",
})
]]--
