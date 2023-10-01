---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if door_mod then

	doors.register_door("ethereal:door_sakura", {
		tiles = {
			{name = "ethereal_sakura_door.png", backface_culling = true}
		},
		description = S("Sakura Wood Door"),
		inventory_image = "ethereal_sakura_door_inv.png",
		groups = {
			snappy = 1, choppy = 2, oddly_breakable_by_hand = 2,
			flammable = 2
		},
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		recipe = {
			{"group:stick",  "default:paper"},
			{"default:paper",  "group:stick"},
			{"ethereal:sakura_wood", "ethereal:sakura_wood"}
		}
	})

	minetest.register_alias("ethereal:sakura_door", "ethereal:door_sakura")
	minetest.register_alias("ethereal:sakura_door_a", "ethereal:door_sakura_a")
	minetest.register_alias("ethereal:sakura_door_b", "ethereal:door_sakura_b")
end
]]--
