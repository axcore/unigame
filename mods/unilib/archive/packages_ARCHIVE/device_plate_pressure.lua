---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function plate.construct(pos)
	local timer = minetest.get_node_timer(pos)
	timer:start(0.1)
end

function plate.timer(pos)
	local objs = minetest.get_objects_inside_radius(pos, 0.8)
	if not next(objs) or not doors.get then return true end

	local minp = {x = pos.x - 2, y = pos.y, z = pos.z - 2}
	local maxp = {x = pos.x + 2, y = pos.y, z = pos.z + 2}
	local doors = minetest.find_nodes_in_area(minp, maxp, "group:door")

	for _, player in pairs(objs) do
		if player:is_player() then
			for i = 1, #doors do
				door_toggle(pos, doors[i], player)
			end
			break
		end
	end

	return true
end

function plate.register(material, desc, def)
	xdecor.register("pressure_" .. material .. "_off", {
		description = def.description or (desc .. " Pressure Plate"),
		tiles = {"xdecor_pressure_" .. material .. ".png"},
		use_texture_alpha = ALPHA_OPAQUE,
		drawtype = "nodebox",
		node_box = xdecor.pixelbox(16, {{1, 0, 1, 14, 1, 14}}),
		groups = def.groups,
		sounds = def.sounds,
		sunlight_propagates = true,
		on_rotate = screwdriver.rotate_simple,
		on_construct = plate.construct,
		on_timer = plate.timer
	})
	xdecor.register("pressure_" .. material .. "_on", {
		tiles = {"xdecor_pressure_" .. material .. ".png"},
		use_texture_alpha = ALPHA_OPAQUE,
		drawtype = "nodebox",
		node_box = xdecor.pixelbox(16, {{1, 0, 1, 14, 0.4, 14}}),
		groups = def.groups,
		sounds = def.sounds,
		drop = "xdecor:pressure_" .. material .. "_off",
		sunlight_propagates = true,
		on_rotate = screwdriver.rotate_simple
	})
end

plate.register("wood", "Wooden", {
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2},
	description = S("Wooden Pressure Plate"),
})
minetest.register_craft({
	output = "xdecor:pressure_wood_off",
	type = "shapeless",
	recipe = {"group:wood", "group:wood"}
})

plate.register("stone", "Stone", {
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	description =  S("Stone Pressure Plate"),
})
minetest.register_craft({
	output = "xdecor:pressure_stone_off",
	type = "shapeless",
	recipe = {"group:stone", "group:stone"}
})
]]--
