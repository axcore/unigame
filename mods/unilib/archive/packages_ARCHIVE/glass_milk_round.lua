---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("unifieddyes") then

	minetest.register_node("darkage:milk_glass_round", {
		description = "Milky Medieval Round Glass (Good for colorization)",
		drawtype = "glasslike",
		tiles = {"darkage_milk_glass_round.png"},
		use_texture_alpha = "blend",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		sunlight_propagates = true,
		groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1, ud_param2_colorable = 1},
		sounds = default.node_sound_glass_defaults()
	})
	-- Craft
	minetest.register_craft({
		output = "darkage:milk_glass_round",
		type = "shapeless",
		recipe = {"darkage:glass_round", "dye:white"},
	})

    unifieddyes.register_color_craft({
        output = "darkage:milk_glass_round",
        palette = "extended",
        type = "shapeless",
        neutral_node = "",
        recipe = {
                 "darkage:milk_glass_round",
                 "MAIN_DYE"
        }
    })

	-- Recycling
	minetest.register_craft({
		output = "darkage:glass_round 1",
		recipe = {{"darkage:milk_glass_round"}}
	})

end
]]--
