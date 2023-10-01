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
local turf_cut = function(itemstack, user, pointed_thing)

	local player_name = user:get_player_name()

	--quit if not valid
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local node = minetest.get_node(pos)

	--use healthy grass, or snowy ground... (it is a cold climate technique)
	if node.name  == "default:dirt_with_grass" or node.name  == "default:dirt_with_snow" then
		--take turf
		minetest.sound_play("dig_crumbly",{pos=pos, max_hear_distance = 5, loop=false, gain=0.5})
		local inv = user:get_inventory()
		inv:add_item("main", "earthbuild:turf")

		--chance of depleting dirt
		local chance = math.random(1,2)
		if chance == 1 then
			minetest.set_node(pos, {name="air"})
			--minetest.dig_node(pos)
		else
			minetest.set_node(pos, {name="default:dirt"})
		end

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

minetest.register_tool("earthbuild:turf_cutter", {
	description = "Turf Cutter",
	inventory_image = "earthbuild_turf_cutter.png",
	groups = {flammable = 2},
	sound = {breaks = "default_tool_breaks"},
	on_use = turf_cut
})
minetest.register_craft({
	output = 'earthbuild:turf_cutter',
	recipe = {
		{'group:stick','default:shovel_wood',''},
	}
})
]]--
