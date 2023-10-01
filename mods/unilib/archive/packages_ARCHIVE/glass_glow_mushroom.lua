---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cucina_vegana:mushroomlight_glass", {
	description = S("Mushroomlight Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"cucina_vegana_mushroom_light.png","cucina_vegana_mushroom_light_detail.png"},
	paramtype = "light",
    light_source = 3,
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft({
        output = "cucina_vegana:mushroomlight_glass 4",
        recipe = {
                  {"","default:glass",""},
                  {"default:glass","default:torch","default:glass"},
                  {"","default:glass",""},
                }
})
]]--
