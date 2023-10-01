---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Remove Iron Lump -> Steel Ingot Recipe
minetest.clear_craft({
	type = "cooking",
	recipe = "default:iron_lump"
})

-- Iron Lump -> Iron Ingot
minetest.register_craft({
	type = "cooking",
	output = "pigiron:iron_ingot",
	recipe = "default:iron_lump"
})

minetest.register_craftitem("pigiron:iron_charcoal_mix", {
	description = "Iron and Charcoal Mix",
	inventory_image = "pigiron_iron_ingot.png^pigiron_charcoal_lump.png"
})
minetest.register_craft({
	output = "pigiron:iron_charcoal_mix",
	--type = "shapeless",
	recipe = {
		{"", "pigiron:charcoal_lump", ""},
		{"pigiron:charcoal_lump", "pigiron:iron_ingot", "pigiron:charcoal_lump"},
		{"", "pigiron:charcoal_lump", ""}
	}
})

-- Cook Iron/Charcoal Mix into Steel Ingot
minetest.register_craft({
	output = "default:steel_ingot",
	type = "cooking",
	recipe = "pigiron:iron_charcoal_mix",
	cooktime = 10
})
]]--
