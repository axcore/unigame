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
local function register_pane(name, desc, def)
	xpanes.register_pane(name, {
		description = desc,
		tiles = {"xdecor_" .. name .. ".png"},
		drawtype = "airlike",
		paramtype = "light",
		textures = {"xdecor_" .. name .. ".png", "" ,"xdecor_" .. name .. ".png"},
		inventory_image = "xdecor_" .. name .. ".png",
		wield_image = "xdecor_" .. name .. ".png",
		groups = def.groups,
		sounds = def.sounds or default.node_sound_defaults(),
		recipe = def.recipe
	})
end

register_pane("wood_frame", S("Wood Frame"), {
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = 2, pane = 1, flammable = 2},
	recipe = {
		{"group:wood", "group:stick", "group:wood"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:wood", "group:stick", "group:wood"}
	}
})
]]--
