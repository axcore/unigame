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
local function register_hard_node(name, desc, def)
	def = def or {}
	xdecor.register(name, {
		description = desc,
		tiles = {"xdecor_" .. name .. ".png"},
		groups = def.groups or {cracky = 1},
		sounds = def.sounds or default.node_sound_stone_defaults()
	})
end

register_hard_node("wood_tile", S("Wooden Tile"), {
	groups = {choppy = 1, wood = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "xdecor:wood_tile 2",
	recipe = {
		{"", "group:wood", ""},
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""}
	}
})
]]--
