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
minetest.register_tool("earthbuild:flint_knife", {
	description = "Flint knife",
	inventory_image = "earthbuild_flintknife.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.3, [3]=0.38}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
})
minetest.register_craft({
	output = 'earthbuild:flint_knife',
	recipe = {
		{'default:flint'},
		{'group:stick'},
	}
})
]]--
