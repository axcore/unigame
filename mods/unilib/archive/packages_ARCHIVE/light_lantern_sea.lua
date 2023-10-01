---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("xocean:sea_lantern", {
    description = "Sea Lantern",
    drawtype = "glasslike",
	light_source = 14,
    tiles = {"xocean_lantern.png"},
    paramtype = "light",
    is_ground_content = true,
    sunlight_propagates = true,
    sounds = default.node_sound_glass_defaults(),
    groups = {cracky=3,oddly_breakable_by_hand=3},
})
minetest.register_craft({
	output = '"xocean:sea_lantern" 4',
	recipe = {
		{'default:torch', 'default:glass', 'default:torch', },
		{'default:glass', 'bucket:bucket_water', 'default:glass', },
		{'default:torch', 'default:glass', 'default:torch', },
		},
		replacements = {{ "bucket:bucket_water", "bucket:bucket_empty"}}
})
]]--
