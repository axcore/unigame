---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Loot from the `default` mod is registered here,
-- with the rest being registered in the respective mods
dungeon_loot.registered_loot = {
	-- various items
	{name = "default:stick", chance = 0.6, count = {3, 6}},
	{name = "default:flint", chance = 0.4, count = {1, 3}},

	-- farming / consumable
	{name = "default:apple", chance = 0.4, count = {1, 4}},
	{name = "default:cactus", chance = 0.4, count = {1, 4},
		types = {"sandstone", "desert"}},

	-- minerals
	{name = "default:coal_lump", chance = 0.9, count = {1, 12}},
	{name = "default:gold_ingot", chance = 0.5},
	{name = "default:steel_ingot", chance = 0.4, count = {1, 6}},
	{name = "default:mese_crystal", chance = 0.1, count = {2, 3}},

	-- tools
	{name = "default:sword_wood", chance = 0.6},
	{name = "default:pick_stone", chance = 0.3},
	{name = "default:axe_diamond", chance = 0.05},

	-- natural materials
	{name = "default:sand", chance = 0.8, count = {4, 32}, y = {-64, 32768},
		types = {"normal"}},
	{name = "default:desert_sand", chance = 0.8, count = {4, 32}, y = {-64, 32768},
		types = {"sandstone"}},
	{name = "default:desert_cobble", chance = 0.8, count = {4, 32},
		types = {"desert"}},
	{name = "default:snow", chance = 0.8, count = {8, 64}, y = {-64, 32768},
		types = {"ice"}},
	{name = "default:dirt", chance = 0.6, count = {2, 16}, y = {-64, 32768},
		types = {"normal", "sandstone", "desert"}},
	{name = "default:obsidian", chance = 0.25, count = {1, 3}, y = {-32768, -512}},
	{name = "default:mese", chance = 0.15, y = {-32768, -512}},
}
]]--
