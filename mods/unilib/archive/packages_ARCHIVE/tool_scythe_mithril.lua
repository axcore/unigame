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
farming.scythe_not_drops = {"farming:trellis", "farming:beanpole"}

farming.add_to_scythe_not_drops = function(item)
	table.insert(farming.scythe_not_drops, item)
end

minetest.register_tool("farming:scythe_mithril", {
	description = S("Mithril Scythe (Use to harvest and replant crops)"),
	inventory_image = "farming_scythe_mithril.png",
	sound = {breaks = "default_tool_breaks"},

	on_use = function(itemstack, placer, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local name = placer:get_player_name()

		if minetest.is_protected(pos, name) then
			return
		end

		local node = minetest.get_node_or_nil(pos)

		if not node then
			return
		end

		local def = minetest.registered_nodes[node.name]

		if not def then
			return
		end

		if not def.drop then
			return
		end

		if not def.groups
		or not def.groups.plant then
			return
		end

		local drops = minetest.get_node_drops(node.name, "")

		if not drops
		or #drops == 0
		or (#drops == 1 and drops[1] == "") then
			return
		end

		-- get crop name
		local mname = node.name:split(":")[1]
		local pname = node.name:split(":")[2]
		local sname = tonumber(pname:split("_")[2])
		pname = pname:split("_")[1]

		if not sname then
			return
		end

		-- add dropped items
		for _, dropped_item in pairs(drops) do

			-- dont drop items on this list
			for _, not_item in pairs(farming.scythe_not_drops) do

				if dropped_item == not_item then
					dropped_item = nil
				end
			end

			if dropped_item then

				local obj = minetest.add_item(pos, dropped_item)

				if obj then

					obj:set_velocity({
						x = math.random(-10, 10) / 9,
						y = 3,
						z = math.random(-10, 10) / 9
					})
				end
			end
		end

		-- Run script hook
		for _, callback in pairs(core.registered_on_dignodes) do
			callback(pos, node, placer)
		end

		-- play sound
		minetest.sound_play("default_grass_footstep", {pos = pos, gain = 1.0})

		local replace = mname .. ":" .. pname .. "_1"

		if minetest.registered_nodes[replace] then

			local p2 = minetest.registered_nodes[replace].place_param2 or 1

			minetest.set_node(pos, {name = replace, param2 = p2})
		else
			minetest.set_node(pos, {name = "air"})
		end

		if not farming.is_creative(name) then

			itemstack:add_wear(65535 / 150) -- 150 uses

			return itemstack
		end
	end,
})

minetest.register_craft({
    output = "farming:scythe_mithril",
    recipe = {
        {"", "moreores:mithril_ingot", "moreores:mithril_ingot"},
        {"moreores:mithril_ingot", "", "group:stick"},
        {"", "", "group:stick"}
    }
})
]]--
