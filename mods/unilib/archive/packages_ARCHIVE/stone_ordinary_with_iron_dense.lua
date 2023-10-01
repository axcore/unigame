---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function underch.dense_ores.register_ore(name, id, texture, item)
	minetest.register_node("underch:" .. id .. "_dense_ore", {
		description = name .. " Dense Ore",
		tiles = {"default_stone.png^" .. texture .. "^(" .. texture .. "^[transform7)"},
		groups = {cracky = 1},
		drop = {
			items = {{items = {item .. " 2"}}, {items = {item}, rarity = 2}}
		},
		sounds = default.node_sound_stone_defaults(),
	})
end

underch.dense_ores.register_ore("Iron", "iron", "default_mineral_iron.png", "default:iron_lump");
]]--
