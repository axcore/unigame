---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:salt", {
	description = S("Salt"),
	inventory_image = "farming_salt.png",
	wield_image = "farming_salt.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_salt.png"},
	groups = {food_salt = 1, vessel = 1, dig_immediate = 3,
			attached_node = 1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	-- special function to make salt crystals form inside water
	dropped_step = function(self, pos, dtime)

		self.ctimer = (self.ctimer or 0) + dtime
		if self.ctimer < 15.0 then return end
		self.ctimer = 0

		local needed

		if self.node_inside
		and self.node_inside.name == "default:water_source" then
			needed = 8

		elseif self.node_inside
		and self.node_inside.name == "default:river_water_source" then
			needed = 9
		end

		if not needed then return end

		local objs = core.get_objects_inside_radius(pos, 0.5)

		if not objs or #objs ~= 1 then return end

		local salt, ent = nil, nil

		for k, obj in pairs(objs) do

			ent = obj:get_luaentity()

			if ent and ent.name == "__builtin:item"
			and ent.itemstring == "farming:salt " .. needed then

				obj:remove()

				core.add_item(pos, "farming:salt_crystal")

				return false -- return with no further action
			end
		end
	end
})
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:salt",
	recipe = "bucket:bucket_water",
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_node("farming:salt_crystal", {
	description = ("Salt crystal"),
	inventory_image = "farming_salt_crystal.png",
	wield_image = "farming_salt_crystal.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	light_source = 1,
	tiles = {"farming_salt_crystal.png"},
	groups = { dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
})
minetest.register_craft({
--	type = "shapeless",
	output = "farming:salt 9",
	recipe = {
		{"farming:salt_crystal", "farming:mortar_pestle"}
	},
	replacements = {{"farming:mortar_pestle", "farming:mortar_pestle"}}
})
minetest.register_craft({
	output = "farming:salt_crystal",
	recipe = {
		{"farming:salt", "farming:salt", "farming:salt"},
		{"farming:salt", "farming:salt", "farming:salt"},
		{"farming:salt", "farming:salt", "farming:salt"}
	}
})
]]--
