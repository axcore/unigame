---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("aotearoa:quicklime", {
	description = "Quicklime",
	inventory_image = "aotearoa_quicklime.png",
})
minetest.register_craft({
	type = "cooking",
	output = "aotearoa:quicklime",
	recipe = "aotearoa:crushed_lime",
})

minetest.register_craft({
	type = "cooking",
	output = "earthbuild:quicklime 6",
	recipe = "default:gravel",
	cooktime = 3,
})
minetest.register_craft({
	type = "cooking",
	output = "earthbuild:quicklime 9",
	recipe = "default:coral_skeleton",
	cooktime = 3,
})
]]--
