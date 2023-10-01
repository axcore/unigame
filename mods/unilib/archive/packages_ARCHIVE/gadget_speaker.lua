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
for _, v in ipairs({"radio", "speaker"}) do
	xdecor.register(v, {
		description = v:gsub("^%l", string.upper),
		on_rotate = screwdriver.rotate_simple,
		tiles = {
			"xdecor_" .. v .. "_top.png",
			"xdecor_" .. v .. "_side.png",
			"xdecor_" .. v .. "_side.png",
			"xdecor_" .. v .. "_side.png",
			"xdecor_" .. v .. "_back.png",
			"xdecor_" .. v .. "_front.png",
		},
		groups = {cracky = 2, not_cuttable = 1},
	})
end
minetest.register_craft({
	output = "xdecor:speaker",
	recipe = {
		{"default:gold_ingot", "default:copper_ingot", "default:gold_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"default:gold_ingot", "default:copper_ingot", "default:gold_ingot"}
	}
})
]]--
