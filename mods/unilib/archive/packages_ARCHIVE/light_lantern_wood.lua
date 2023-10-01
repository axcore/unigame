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
local xdecor_lightbox = {
	wooden = S("Wooden Light Box"),
	wooden2 = S("Wooden Light Box 2"),
}

for l, desc in pairs(xdecor_lightbox) do
	xdecor.register(l .. "_lightbox", {
		description = desc,
		tiles = {"xdecor_" .. l .. "_lightbox.png"},
		groups = {cracky = 3, choppy = 3, oddly_breakable_by_hand = 2},
		light_source = 13,
		sounds = default.node_sound_glass_defaults()
	})
end

minetest.register_craft({
	output = "xdecor:wooden_lightbox",
	recipe = {
		{"group:stick", "default:torch", "group:stick"},
		{"group:stick", "default:glass", "group:stick"},
		{"group:stick", "default:torch", "group:stick"}
	}
})

minetest.register_craft({
	output = "xdecor:wooden2_lightbox",
	type = "shapeless",
	recipe = {"xdecor:wooden_lightbox"},
})
]]--
