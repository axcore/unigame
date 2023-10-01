---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    anvil
-- Code:    GPL-3.0-only
-- Media:   GPL-3.0-only
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
anvil.make_unrepairable = function(item_name)
	local item_def = minetest.registered_items[item_name]
	if item_def then
		-- Drop table reference. Copy other values over.
		local groups = {not_repaired_by_anvil = 1}
		for k, v in pairs(item_def.groups) do
			groups[k] = v
		end
		minetest.override_item(item_name, {groups = groups})
	end
end

if minetest.get_modpath("technic") then
	-- make rechargeable technic tools unrepairable
	anvil.make_unrepairable("technic:water_can")
	anvil.make_unrepairable("technic:lava_can")
	anvil.make_unrepairable("technic:flashlight")
	anvil.make_unrepairable("technic:battery")
	anvil.make_unrepairable("technic:vacuum")
	anvil.make_unrepairable("technic:prospector")
	anvil.make_unrepairable("technic:sonic_screwdriver")
	anvil.make_unrepairable("technic:chainsaw")
	anvil.make_unrepairable("technic:laser_mk1")
	anvil.make_unrepairable("technic:laser_mk2")
	anvil.make_unrepairable("technic:laser_mk3")
	anvil.make_unrepairable("technic:mining_drill")
	anvil.make_unrepairable("technic:mining_drill_mk2")
	anvil.make_unrepairable("technic:mining_drill_mk2_1")
	anvil.make_unrepairable("technic:mining_drill_mk2_2")
	anvil.make_unrepairable("technic:mining_drill_mk2_3")
	anvil.make_unrepairable("technic:mining_drill_mk2_4")
	anvil.make_unrepairable("technic:mining_drill_mk3")
	anvil.make_unrepairable("technic:mining_drill_mk3_1")
	anvil.make_unrepairable("technic:mining_drill_mk3_2")
	anvil.make_unrepairable("technic:mining_drill_mk3_3")
	anvil.make_unrepairable("technic:mining_drill_mk3_4")
	anvil.make_unrepairable("technic:mining_drill_mk3_5")
end
]]--
