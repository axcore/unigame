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

register_hard_node("packed_ice", S("Packed Ice"), {
	groups = {cracky = 1, puts_out_fire = 1, slippery = 3},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft({
	output = "xdecor:packed_ice",
	recipe = {
		{"default:ice", "default:ice"},
		{"default:ice", "default:ice"}
	}
})
]]--
