---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
cheese.aged_cheeses = {"parmesan","fontal","gruyere","emmental","monteray_jack","asiago","toma","gouda","gorgonzola","stilton","brie","stracchino"}-- full list of cheeses
for k, v in pairs(cheese.aged_cheeses) do
	local aged = {
		description = S(""..v:gsub("_", " "):gsub("(%a)(%a+)", function(a, b) return string.upper(a) .. string.lower(b) end) ),
		inventory_image = v..".png",
		on_use = minetest.item_eat(2),
		groups = {food = 2, food_cheese = 1},
	}
	minetest.register_craftitem("cheese:"..v, aged )
	if cheese.ui then
		unified_inventory.register_craft({
			type = "cheese_rack_aging",
			items = {"cheese:curd"},
			output = "cheese:"..v
		})
	end
	if cheese.i3 then
		i3.register_craft({
			type = "cheese_rack_aging",
			items = {"cheese:curd"},
			result = "cheese:"..v
		})
	end
end
]]--
