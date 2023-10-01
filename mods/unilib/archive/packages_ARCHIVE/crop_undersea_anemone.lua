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
local step = 5
local light = 8 -- minimum Light needed
local del = 8  -- all 8 Seconds a
local chan = 5 -- Chance of 1 to 5
local name = "aqua_farming:sea_anemone"
local desc = S("Sea Anemone")

local def = {
                basenode = "default:gravel",
                nodename = name,
                description = desc,
                steps = step,
                min_light = light,
                delay = del,
                chance = chan,
                drop = {items = {
                                        {items = {name .. "_item 2"}},
                                        {items = {name .. "_seed 2"}},
                                        {items = {name .. "_item 3", rarity = 8}},
                                        {items = {name .. "_seed 3", rarity = 10}},

                                }, -- items

                        }, -- drop

            } -- def

minetest.register_craftitem(name .. "_item", {
        description = desc .. " " .. S("(raw)"),
        groups = {food = 1, food_vegan = 1, seafood = 1},
        inventory_image = "aqua_farming_" .. name:split(":")[2] .. "_item.png",
        on_use = minetest.item_eat(5),
})

aqua_farming.register_plant(def)

local name = "aqua_farming:sea_anemone"

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
        "snowy_grassland_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        "icesheet_ocean",
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
        "snowy_grassland_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        "icesheet_ocean",
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
    place_on = {"default:gravel"},
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
        "snowy_grassland_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        "icesheet_ocean",
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
        "snowy_grassland_ocean",
        "coniferous_forest_ocean",
        "cold_desert_ocean",
        "icesheet_ocean",
        },
    y_max = -5,
    y_min = -40,
    flags = "force_placement",
    decoration = name .. "_wild",
    param2 = 48,
    param2_max = 96,
})
]]--
