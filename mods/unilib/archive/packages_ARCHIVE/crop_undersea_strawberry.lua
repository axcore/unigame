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
local light = 8
local del = 10
local chan = 15
local name = "aqua_farming:sea_strawberry"
local desc = S("Sea Strawberry")

local def = {
                basenode = "default:dirt",
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
        groups = {food = 1, food_vegan = 1, seafood = 1, food_strawberry = 1},
        inventory_image = "aqua_farming_" .. name:split(":")[2] .. "_item.png",
        on_use = minetest.item_eat(3),
})

local name = "aqua_farming:sea_strawberry"

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:sand"},
    place_offset_y = -1,
    sidelen = 4,
        noise_params = {
        offset = -4,
        scale = 4,
        spread = {x = 50, y = 50, z = 50},
        seed = 7013,
        octaves = 3,
        persist = 0.7,
    },
    biomes = {
        "desert_ocean",
        "savanna_ocean",
        "rainforest_ocean",
    },
    y_max = -2,
    y_min = -30,
    flags = "force_placement",
    decoration = {name .. "_wild"},
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:dirt"},
    place_offset_y = -1,
    sidelen = 4,
    noise_params = {
        offset = -4,
        scale = 4,
        spread = {x = 50, y = 50, z = 50},
        seed = 7013,
        octaves = 3,
        persist = 0.7,
    },
    biomes = {
        "desert_ocean",
        "savanna_ocean",
        "rainforest_ocean",
    },
    y_max = -2,
    y_min = -30,
    flags = "force_placement",
    decoration = {name .. "_wild"},
})


minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:desert_sand"},
    place_offset_y = -1,
    sidelen = 4,
    noise_params = {
        offset = -4,
        scale = 4,
        spread = {x = 50, y = 50, z = 50},
        seed = 7013,
        octaves = 3,
        persist = 0.7,
    },
    biomes = {
        "desert_ocean",
        "savanna_ocean",
        "rainforest_ocean",
        },
    y_max = -2,
    y_min = -30,
    flags = "force_placement",
    decoration = {name .. "_wild"},
})
]]--
