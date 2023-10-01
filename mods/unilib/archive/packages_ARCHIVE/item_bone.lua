---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bonemeal:bone", {
	description = S("Bone"),
	inventory_image = "bonemeal_bone.png",
	groups = {bone = 1}
})

-- add bones to dirt
minetest.override_item("default:dirt", {
	drop = {
		max_items = 1,
		items = {
			{
				items = {"bonemeal:bone"},
				rarity = 40
			},
			{
				items = {"default:dirt"}
			}
		}
	}
})
]]--
