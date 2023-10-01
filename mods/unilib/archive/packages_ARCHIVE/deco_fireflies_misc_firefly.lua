---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
    name = "fireflies:firefly_low",
    deco_type = "simple",
    place_on = {
        "default:dirt_with_grass",
        "default:dirt_with_coniferous_litter",
        "default:dirt_with_rainforest_litter",
        "default:dirt"
    },
    place_offset_y = 2,
    sidelen = 80,
    fill_ratio = 0.0005,
    biomes = {
        "deciduous_forest",
        "coniferous_forest",
        "rainforest",
        "rainforest_swamp"
    },
    y_max = 31000,
    y_min = -1,
    decoration = "fireflies:hidden_firefly",
})

minetest.register_decoration({
    name = "fireflies:firefly_high",
    deco_type = "simple",
    place_on = {
        "default:dirt_with_grass",
        "default:dirt_with_coniferous_litter",
        "default:dirt_with_rainforest_litter",
        "default:dirt"
    },
    place_offset_y = 3,
    sidelen = 80,
    fill_ratio = 0.0005,
    biomes = {
        "deciduous_forest",
        "coniferous_forest",
        "rainforest",
        "rainforest_swamp"
    },
    y_max = 31000,
    y_min = -1,
    decoration = "fireflies:hidden_firefly",
})
]]--
