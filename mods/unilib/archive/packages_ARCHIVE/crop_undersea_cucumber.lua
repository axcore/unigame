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
local step = 8
local light = 6
local del = 9
local chan = 10
local name = "aqua_farming:sea_cucumber"
local desc = S("Sea Cucumber")

local def = {
                basenode = "default:sand",
                nodename = name,
                description = desc,
                steps = step,
                min_light = light,
                delay = del,
                chance = chan,
                drop = {items = {
                                    {items = {name .. "_seed 2"}},
                                    {items = {name .. "_item 4"}},
                                    {items = {name .. "_seed 3", rarity = 15}},
                                },
                        },
            } -- def

aqua_farming.register_plant(def)

minetest.register_craftitem(name .. "_item", {
        description = desc,
        groups = {food = 1, food_vegan = 1, seafood = 1, food_cucumber = 1},
        inventory_image = "aqua_farming_" .. name:split(":")[2] .. "_item.png",
        on_use = minetest.item_eat(4),
})

local name = "aqua_farming:sea_cucumber"

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:sand"},
    place_offset_y = -1,
    sidelen = 16,
    noise_params = {
        offset = -0.04,
        scale = 0.3,
        spread = {x = 70, y = 70, z = 70},
        seed = 87112,
        octaves = 3,
        persist = 0.5
    },
    biomes = {
        "taiga_ocean",
        "tundra_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        },
    y_max = -5,
    y_min = -40,
    flags = "force_placement",
    decoration = name .. "_wild",
    param2 = 48,
    param2_max = 96,
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:silver_sand"},
    place_offset_y = -1,
    sidelen = 16,
    noise_params = {
        offset = -0.04,
        scale = 0.3,
        spread = {x = 70, y = 70, z = 70},
        seed = 87112,
        octaves = 3,
        persist = 0.5
    },
    biomes = {
        "taiga_ocean",
        "tundra_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        },
    y_max = -5,
    y_min = -40,
    flags = "force_placement",
    decoration = name .. "_wild",
    param2 = 48,
    param2_max = 96,
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:desert_sand"},
    place_offset_y = -1,
    sidelen = 16,
    noise_params = {
        offset = -0.04,
        scale = 0.3,
        spread = {x = 70, y = 70, z = 70},
        seed = 87112,
        octaves = 3,
        persist = 0.5
    },
    biomes = {
        "taiga_ocean",
        "tundra_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        },
    y_max = -5,
    y_min = -40,
    flags = "force_placement",
    decoration = name .. "_wild",
    param2 = 48,
    param2_max = 96,
})
]]--
