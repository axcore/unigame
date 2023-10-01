---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("earthbuild:whitewash", {
	description = "Whitewash",
	inventory_image = "earthbuild_whitewash.png",
	stack_max = 99,
})
minetest.register_craft({
	output = 'earthbuild:whitewash 6',
	recipe = {
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'','earthbuild:clay_pot_water',''},
	},
	replacements = {{"earthbuild:clay_pot_water", "earthbuild:clay_pot"}}
})
minetest.register_craft({
	output = 'earthbuild:whitewash 6',
	recipe = {
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'','earthbuild:clay_pot_river_water',''},
	},
	replacements = {{"earthbuild:clay_pot_river_water", "earthbuild:clay_pot"}}
})
minetest.register_craft({
	output = 'earthbuild:whitewash 6',
	recipe = {
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'','bucket:bucket_water',''},
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})
minetest.register_craft({
	output = 'earthbuild:whitewash 6',
	recipe = {
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'earthbuild:quicklime','earthbuild:quicklime','earthbuild:quicklime'},
		{'','bucket:bucket_river_water',''},
	},
	replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}}
})
]]--
