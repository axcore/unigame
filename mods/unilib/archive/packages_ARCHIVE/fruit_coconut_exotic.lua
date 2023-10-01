---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("fruit:coconut", {
	description = "Coconut",
	inventory_image = "fruit_coconut.png",
	on_use = function(itemstack, placer, pointed_thing)
		if pointed_thing.under == nil then
		return
		end
		local item = minetest.get_node(pointed_thing.under).name
		if minetest.get_item_group(item, "cracky") ~= 0 then
		itemstack:take_item()
		minetest.add_item(pointed_thing.above, "fruit:coconut_open")
		end
		return itemstack
	end,
})
minetest.register_craft( {
	output = "fruit:coconut",
	recipe = {
		{ "fruit:palm_leaves_coconut",},
	}
})
minetest.register_craft( {
	output = "fruit:coconut_open 2",
	recipe = {
		{ "fruit:coconut",},
	}
})

minetest.register_craftitem("fruit:coconut_open", {
	description = "Cracked Coconut",
	inventory_image = "fruit_coconut_opened.png",
	on_use = minetest.item_eat(2)
})
]]--
