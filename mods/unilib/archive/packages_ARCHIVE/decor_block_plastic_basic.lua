---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plastic_block
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- get the list of dyes in MTG
local dyes = dye.dyes

-- some colors don't look in-game as they are called, these values fit better
local special_colors = {
	dark_grey = "#222222",
	dark_green = "#004400",
	green = "#00BB00",
	pink = "#FF6FFF",
	violet = "#990099",
	brown = "#441c12",
}

-- register like a wool
for _, dye in ipairs(dyes) do
	local color, desc = unpack(dye)
	
	-- special colirization
	local colorize = color
	if special_colors[color] then colorize = special_colors[color] end
	
	minetest.register_node("plastic_block:" .. color, {
		description = S(desc .. " Plastic Block"),
		-- this texture is nothing but "basic_materials_plastic_sheet.png" stretched in Gimp
		tiles = {"plastic_block_side.png^[colorize:"..colorize..":191"}, -- 191 looks fine
		is_ground_content = false,
		groups = {snappy = 1, choppy = 1, oddly_breakable_by_hand = 2, plastic = 1},
		
		-- not sure, but later should change these sounds, they're not "plastic" enough
		sounds = {
			dig = {"dafault_dig_oddly_breakable_by_hand", gain = 0.25},
			dug = {name = "default_dug_node", gain = 0.25},
			place = {name = "default_place_node_hard", gain = 1.0},
			footstep = {name = "default_hard_footstep", gain = 0.2},
		}
	})
	
	-- wool-like coloring recipe
	minetest.register_craft{
		type = "shapeless",
		output = "plastic_block:" .. color,
		recipe = {"group:dye,color_" .. color, "group:plastic"},
	}
	
	
	-- moreblocks code
	if minetest.global_exists("stairsplus") ~= nil then
		local nodename = "plastic_block:" .. color
		local ndef = table.copy(minetest.registered_nodes[nodename])
		ndeg.groups.plastic = nil
		ndef.sunlight_propagates = true

		stairsplus:register_all("moreblocks", color, nodename, ndef)
	end

end

-- finally, get a block from 9 sheets
minetest.register_craft({
	output = "plastic_block:white",
	recipe = {
		{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
		{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
		{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
	}
})
]]--
