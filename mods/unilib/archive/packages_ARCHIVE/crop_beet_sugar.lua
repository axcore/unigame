---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    agriculture
-- Code:    WTFPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
agriculture.register_crop("sugar_beet", {
	description = "Sugar Beet",
	steps = 5,
	growtime = 1250,
	cond = {
		fertility = {"grassland"}
	},
	craft_seed_by_harvest = true,
})

core.register_craftitem("agriculture:sugar", {
	description = "Sugar",
	inventory_image = "agriculture_sugar.png",
})

-- crafting
core.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "agriculture:sugar",
	recipe = "agriculture:sugar_beet"
})
]]--
