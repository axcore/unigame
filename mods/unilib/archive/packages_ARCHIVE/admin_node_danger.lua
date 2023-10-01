---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
for damage_num=1,5,1 do
register_node("maptools:damage_" .. damage_num, {
	description = S("Damaging Block (%s)"):format(damage_num),
	inventory_image = "default_steel_block.png^farming_cotton_" .. damage_num .. ".png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	damage_per_second = damage_num,
	paramtype = "light",
	sunlight_propagates = true,
})
end

register_node("maptools:kill", {
	description = S("Kill Block"),
	inventory_image = "default_steel_block.png^dye_black.png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	damage_per_second = 20,
	paramtype = "light",
	sunlight_propagates = true,
})

register_node("maptools:drowning", {
	description = S("Drownable Air"),
	inventory_image = "default_steel_block.png^dye_black.png",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	walkable = false,
	drowning = 1,
	sunlight_propagates = true,
})
]]--
