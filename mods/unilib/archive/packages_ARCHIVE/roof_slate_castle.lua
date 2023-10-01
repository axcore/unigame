---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("castle_masonry:roofslate", {
	drawtype = "raillike",
	description = S("Roof Slates"),
	inventory_image = "castle_slate.png",
	paramtype = "light",
	walkable = false,
	tiles = {'castle_slate.png'},
	climbable = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {cracky=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})
if mod_building_blocks then
	minetest.register_craft({
		output = "castle_masonry:roofslate 4",
		recipe = {
			{ "building_blocks:Tar" , "default:gravel" },
			{ "default:gravel",       "building_blocks:Tar" }
		}
	})

	minetest.register_craft( {
		output = "castle_masonry:roofslate 4",
		recipe = {
			{ "default:gravel",       "building_blocks:Tar" },
			{ "building_blocks:Tar" , "default:gravel" }
		}
	})
end
]]--
