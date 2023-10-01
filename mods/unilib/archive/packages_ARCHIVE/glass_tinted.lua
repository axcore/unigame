---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local colours = {
{"red", "Red"},
{"green", "Green"},
{"blue", "Blue"},
{"yellow", "Yellow"},
{"cyan", "Cyan"},
{"brown", "Brown"},
{"orange", "Orange"},
{"violet", "Violet"},
{"magenta", "Magenta"},
{"dark_green", "Dark Green"},
{"dark_grey", "Dark Grey"},
{"grey", "Grey"},
{"white", "White"},
{"black", "Black"},
{"pink", "Pink"},
}

for _, row in ipairs(colours) do
local colour = row[1]
local desc = row[2]
minetest.register_node("decoblocks:"..colour.."_glass", {
	description = ""..desc.." Stained Glass",
	drawtype = "glasslike",
	tiles = {"decoblocks_"..colour.."_glass.png"},
	use_texture_alpha = "blend",
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=1, oddly_breakable_by_hand=3, snappy=2},
})
xpanes.register_pane(""..colour.."_glass", {
	description = ""..desc.." Stained Glass Pane",
	textures = {"decoblocks_"..colour.."_glass.png","decoblocks_"..colour.."_glass.png","decoblocks_"..colour.."_glass.png"},
	use_texture_alpha = "blend",
	inventory_image = "decoblocks_"..colour.."_glass.png",
	wield_image = "decoblocks_"..colour.."_glass.png",
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"decoblocks:"..colour.."_glass", "decoblocks:"..colour.."_glass", "decoblocks:"..colour.."_glass"},
		{"decoblocks:"..colour.."_glass", "decoblocks:"..colour.."_glass", "decoblocks:"..colour.."_glass"},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = 'decoblocks:'..colour..'_glass 8',
	recipe = {
		'default:glass',
		'default:glass',
		'default:glass',
		'default:glass',
		"dye:"..colour,
		'default:glass',
		'default:glass',
		'default:glass',
		'default:glass',
	}
})
end
]]--
