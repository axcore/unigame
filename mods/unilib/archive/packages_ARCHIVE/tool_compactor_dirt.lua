---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local ram = function(itemstack, user, pointed_thing)

	local player_name = user:get_player_name()

	--quit if not valid
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local node = minetest.get_node(pos)

	if minetest.get_item_group(node.name, "soil") == 1 then
		minetest.sound_play("dig_crumbly",{pos=pos, max_hear_distance = 5, loop=false, gain=0.5})

		minetest.set_node(pos, {name="earthbuild:compacted_dirt"})

		if not (creative and creative.is_enabled_for
				and creative.is_enabled_for(player_name)) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear(700)
			-- Tool break sound
			if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
				minetest.sound_play(wdef.sound.breaks, {pos = sound_pos, gain = 0.5})
			end
			return itemstack
		end
	end
end

minetest.register_tool("earthbuild:dirt_compactor", {
	description = "Dirt Compactor",
	inventory_image = "earthbuild_dirt_compactor.png",
	groups = {flammable = 2},
	sound = {breaks = "default_tool_breaks"},
	on_use = ram
})
minetest.register_craft({
	output = 'earthbuild:dirt_compactor',
	recipe = {
		{'group:stick','default:shovel_wood','group:stick'},
	}
})
]]--
