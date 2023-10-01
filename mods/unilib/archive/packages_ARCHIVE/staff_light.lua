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
minetest.register_tool("ethereal:light_staff", {
	description = S("Staff of Light"),
	inventory_image = "ethereal_light_staff.png",
	light_source = 13, -- used by other mods
	wield_image = "ethereal_light_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name
		local def = minetest.registered_nodes[node]
		local stone = def and def.groups and def.groups.stone and def.groups.stone == 1

		if ethereal.lightstaff_recipes[node] or stone then

			local glo = ethereal.lightstaff_recipes[node] or "ethereal:glostone"

			minetest.set_node(pos, {name = glo})

			itemstack:add_wear(65535 / 149) -- 150 uses

			return itemstack
		end
	end
})
minetest.register_craft({
	output = "ethereal:light_staff",
	recipe = {
		{"ethereal:illumishroom", "default:mese_crystal", "ethereal:illumishroom"},
		{"ethereal:illumishroom2", "default:steel_ingot", "ethereal:illumishroom2"},
		{"ethereal:illumishroom3", "default:steel_ingot", "ethereal:illumishroom3"}
	}
})
]]--
