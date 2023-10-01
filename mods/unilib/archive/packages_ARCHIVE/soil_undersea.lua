---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("aqua_farming:water_soil", {
	description = S("Water Soil"),
	tiles = {minetest.registered_nodes["default:silver_sand"].tiles[1] .. "^aqua_farming_water_soil.png",
             minetest.registered_nodes["default:silver_sand"].tiles[1]},
    drop = "default:silver_sand",
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})
minetest.register_craft({
                            output = "aqua_farming:water_soil 2",
                            recipe = {
                                        {"default:gravel", "group:seafood", "group:sand"}
                                     },
                         })
]]--
