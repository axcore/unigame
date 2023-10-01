---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:sponge", {
	description = S("Sponge"),
	tiles = {"ethereal_sponge.png"},
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults(),

	after_place_node = function(pos, placer, itemstack, pointed_thing)

		-- get player name
		local name = placer:get_player_name()

		-- is area protected
		if minetest.is_protected(pos, name) then
			return
		end

		-- get water nodes within range
		local num = minetest.find_nodes_in_area(
			{x = pos.x - 3, y = pos.y - 3, z = pos.z - 3},
			{x = pos.x + 3, y = pos.y + 3, z = pos.z + 3},
			{"group:water"})

		-- no water
		if #num == 0 then return end

		-- replace water nodes with sponge air
		for _, w in pairs(num) do

			if not minetest.is_protected(pos, name) then
				minetest.swap_node(w, {name = "ethereal:sponge_air"})
			end
		end

		-- replace dry sponge with wet sponge
		minetest.swap_node(pos, {name = "ethereal:sponge_wet"})
	end
})
minetest.register_craft({
	type = "cooking",
	recipe = "ethereal:sponge_wet",
	output = "ethereal:sponge",
	cooktime = 3
})
minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:sponge",
	burntime = 5
})

minetest.register_node("ethereal:sponge_wet", {
	description = S("Wet sponge"),
	tiles = {"ethereal_sponge_wet.png"},
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("ethereal:sponge_air", {
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	pointable = false,
	drop = "",
	groups = {not_in_creative_inventory = 1}
})
default.register_leafdecay({
	trunks = {"ethereal:sponge_wet"},
	leaves = {"ethereal:sponge_air"},
	radius = 3
})
]]--
