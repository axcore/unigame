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

register_pane("chainlink", S("Chainlink"), {
	groups = {cracky = 3, oddly_breakable_by_hand = 2, pane = 1},
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})
]]--
