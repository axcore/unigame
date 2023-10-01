---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("farming") then

	farming.register_hoe(":farming:hoe_iron", {
		description = "Iron Hoe",
		inventory_image = "pigiron_iron_hoe.png",
		max_uses = 150,
		material = "pigiron:iron_ingot"
	})

	-- Toolranks support if farming redo active
	if farming and farming.mod
	and minetest.get_modpath("toolranks") then

		minetest.override_item("farming:hoe_iron", {
			original_description = "Iron Hoe",
			description = toolranks.create_description("Iron Hoe")})
	end
end
]]--
