---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bbq:veggie_packet_raw", {
	description = ("Veggie Packet Raw"),
	inventory_image = "bbq_veggie_packet_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:veggie_packet_raw 2",
	type = "shapeless",
	recipe = {"group:food_pepper_ground", "group:food_tomato", "group:food_potato", "group:food_corn", "bbq:foil"}
})

minetest.register_craftitem("bbq:veggie_packet", {
	description = ("Veggie Packet"),
	inventory_image = "bbq_veggie_packet.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:veggie_packet",
	recipe = "bbq:veggie_packet_raw",
	cooktime = 8,
})
]]--
