---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- can be used to buid real stationary wagons or attached to walls as decoration
minetest.register_node("cottages:wagon_wheel", {
        description = S("wagon wheel"),
        drawtype = "signlike",
        tiles = {"cottages_wagonwheel.png"}, -- done by VanessaE!
        inventory_image = "cottages_wagonwheel.png",
        wield_image = "cottages_wagonwheel.png",
        paramtype = "light",
        paramtype2 = "wallmounted",

        sunlight_propagates = true,
        walkable = false,
        selection_box = {
                type = "wallmounted",
        },
        groups = {choppy=2,dig_immediate=2,attached_node=1},
        legacy_wallmounted = true,
	is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:wagon_wheel 3",
	recipe = {
		{cottages.craftitem_iron, cottages.craftitem_stick,       cottages.craftitem_iron },
		{cottages.craftitem_stick,     cottages.craftitem_steel, cottages.craftitem_stick },
		{cottages.craftitem_iron, cottages.craftitem_stick,       cottages.craftitem_iron }
	}
})
-- run a wagon wheel over dirt :-)
minetest.register_craft({
	output = "cottages:feldweg 4",
	recipe = {
		{"",            "cottages:wagon_wheel", "" },
		{cottages.craftitem_dirt,cottages.craftitem_dirt,cottages.craftitem_dirt }
	},
        replacements = { {'cottages:wagon_wheel', 'cottages:wagon_wheel'}, }
})
]]--
