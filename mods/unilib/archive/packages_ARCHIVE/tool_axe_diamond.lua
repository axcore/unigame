---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("default:axe_diamond", {
	description = S("Diamond Axe"),
	inventory_image = "default_tool_diamondaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})
local craft_ingreds = {
	wood = "group:wood",
	stone = "group:stone",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	mese = "default:mese_crystal",
	diamond = "default:diamond"
}
for name, mat in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "default:axe_".. name,
		recipe = {
			{mat, mat},
			{mat, "group:stick"},
			{"", "group:stick"}
		}
	})
end
]]--
