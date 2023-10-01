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
if creamable[1] == nil then
	-- register a default alternative to still get access to cream, and consequently, butter
	minetest.register_craftitem("cheese:cactus_cream", {
		description = S("Cactus Cream"),
		inventory_image = "coconut_cream.png^[colorize:green:30",
		groups = {food_cream = 1, vegan_alternative = 1, food_vegan = 1},
	})
	--definition of bucket_cactus is in fantasy.lua
	table.insert(creamable, {"cheese:bucket_cactus",	"cheese:cactus_cream 2"})
end

]]--
