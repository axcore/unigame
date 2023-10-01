---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local xdecor_doors = {
	japanese = {
		recipe = {
			{"group:wood", "default:paper"},
			{"default:paper", "group:wood"},
			{"group:wood", "default:paper"}
		},
		desc = S("Japanese Door"),
	},
}

for name, def in pairs(xdecor_doors) do
	if not doors.register then break end
	doors.register(name .. "_door", {
		tiles = {
			{name = "xdecor_" .. name .. "_door.png", backface_culling = true}
		},
		description = def.desc,
		inventory_image = "xdecor_" .. name .. "_door_inv.png",
		protected = door_access(name),
		groups = {choppy = 2, cracky = 2, oddly_breakable_by_hand = 1, door = 1},
		recipe = def.recipe,
		mesecons = mesecons_register,
	})
end
]]--
