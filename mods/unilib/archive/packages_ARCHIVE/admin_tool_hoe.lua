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
local function hoe_area(pos, player)

	-- check for protection
	if minetest.is_protected(pos, player:get_player_name()) then
		minetest.record_protection_violation(pos, player:get_player_name())
		return
	end

	local r = 5 -- radius

	-- remove flora (grass, flowers etc.)
	local res = minetest.find_nodes_in_area(
		{x = pos.x - r, y = pos.y - 1, z = pos.z - r},
		{x = pos.x + r, y = pos.y + 2, z = pos.z + r},
		{"group:flora"})

	for n = 1, #res do
		minetest.swap_node(res[n], {name = "air"})
	end

	-- replace dirt with tilled soil
	res = nil
	res = minetest.find_nodes_in_area_under_air(
		{x = pos.x - r, y = pos.y - 1, z = pos.z - r},
		{x = pos.x + r, y = pos.y + 2, z = pos.z + r},
		{"group:soil"})

	for n = 1, #res do
		minetest.swap_node(res[n], {name = "farming:soil"})
	end
end

local function throw_potion(itemstack, player)

	local playerpos = player:get_pos()

	local obj = minetest.add_entity({
		x = playerpos.x,
		y = playerpos.y + 1.5,
		z = playerpos.z
	}, "farming:hoebomb_entity")

	local dir = player:get_look_dir()
	local velocity = 20

	obj:setvelocity({
		x = dir.x * velocity,
		y = dir.y * velocity,
		z = dir.z * velocity
	})

	obj:setacceleration({
		x = dir.x * -3,
		y = -9.5,
		z = dir.z * -3
	})

	obj:get_luaentity().player = player
end

minetest.register_entity("farming:hoebomb_entity", {
	physical = true,
	visual = "sprite",
	visual_size = {x = 1.0, y = 1.0},
	textures = {"farming_hoe_bomb.png"},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	lastpos = {},
	player = "",

	on_step = function(self, dtime)

		if not self.player then

			self.object:remove()

			return
		end

		local pos = self.object:get_pos()

		if self.lastpos.x ~= nil then

			local vel = self.object:getvelocity()

			-- only when potion hits something physical
			if vel.x == 0
			or vel.y == 0
			or vel.z == 0 then

				if self.player ~= "" then

					-- round up coords to fix glitching through doors
					self.lastpos = vector.round(self.lastpos)

					hoe_area(self.lastpos, self.player)
				end

				self.object:remove()

				return

			end
		end

		self.lastpos = pos
	end
})

minetest.register_craftitem("farming:hoe_bomb", {
	description = S("Hoe Bomb (use or throw on grassy areas to hoe land)"),
	inventory_image = "farming_hoe_bomb.png",
	groups = {flammable = 2, not_in_creative_inventory = 1},
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type == "node" then
			hoe_area(pointed_thing.above, user)
		else
			throw_potion(itemstack, user)

			if not farming.is_creative(user:get_player_name()) then

				itemstack:take_item()

				return itemstack
			end
		end
	end,
})
]]--
