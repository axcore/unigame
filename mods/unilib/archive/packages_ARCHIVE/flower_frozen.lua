---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Flowers
if rawget(_G, "flowers") then
	-- broken flowers
	for _,name in pairs({"dandelion_yellow", "geranium", "rose", "tulip", "dandelion_white", "viola"}) do
		local flowername = "flowers:"..name
		local newname = "snow:flower_"..name
		local flower = minetest.registered_nodes[flowername]
		minetest.register_node(newname, {
			drawtype = "plantlike",
			tiles = { "snow_" .. name .. ".png" },
			sunlight_propagates = true,
			paramtype = "light",
			paramtype2 = "degrotate",
			walkable = false,
			drop = "",
			groups = {snappy=3, attached_node = 1},
			sounds = default.node_sound_leaves_defaults(),
			selection_box = flower.selection_box
		})
	end
end
]]--
