---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("nsspf:amadou", {
	description = "Amadou",
	image = "amadou.png",
})
	minetest.register_craft({
		output = 'nsspf:amadou',
		type = "shapeless",
		recipe = {'nsspf:fomes_fomentarius'},
	})
minetest.register_craft({
	type = "fuel",
	recipe = "nsspf:amadou",
	burntime = 120,
})

if minetest.get_modpath("tnt") then

	minetest.register_craftitem("nsspf:lasting_amadou", {
		description = 'Lasting Amadou',
		image = "lasting_amadou.png",
	})

	minetest.register_craft({
		output = 'nsspf:lasting_amadou',
		type = "shapeless",
		recipe = {'tnt:gunpowder', 'nsspf:amadou'},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "nsspf:lasting_amadou",
		burntime = 300,
	})

end
]]--
