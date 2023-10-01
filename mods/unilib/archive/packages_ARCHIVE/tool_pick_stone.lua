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
minetest.register_tool("default:pick_stone", {
	description = S("Stone Pickaxe"),
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=2.0, [3]=1.00}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
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
		output = "default:pick_".. name,
		recipe = {
			{mat, mat, mat},
			{"", "group:stick", ""},
			{"", "group:stick", ""}
		}
	})
end
]]--
