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
beds.register_bed("earthbuild:primitive_bed", {
	description = "Primitive Bed",
	inventory_image = "earthbuild_primitive_bed.png",
	wield_image = "earthbuild_primitive_bed.png",
  tiles = {
		bottom = {
			"earthbuild_thatch.png^[transformR90",
			"default_wood.png",
			"earthbuild_bed_side.png",
			"earthbuild_bed_side.png^[transformfx",
			"earthbuild_bed_side.png"
		},
		top = {
			"earthbuild_thatch.png^[transformR90",
			"default_wood.png",
			"earthbuild_bed_side.png",
			"earthbuild_bed_side.png^[transformfx",
			"earthbuild_bed_side.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"earthbuild:thatch", "earthbuild:thatch", "earthbuild:thatch"},
		{"group:wood", "group:wood", "group:wood"},
	},
})
]]--
