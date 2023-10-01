---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- The following are deprecated by removing the 'material' field to prevent
-- crafting and removing from creative inventory, to cause them to eventually
-- disappear from worlds. The registrations should be removed in a future
-- release.
farming.register_hoe(":farming:hoe_mese", {
	description = S("Mese Hoe"),
	inventory_image = "farming_tool_mesehoe.png",
	max_uses = 350,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})
]]--
