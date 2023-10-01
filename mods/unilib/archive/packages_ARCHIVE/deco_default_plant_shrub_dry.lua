---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
    name = "default:dry_shrub",
    deco_type = "simple",
    place_on = {"default:desert_sand",
        "default:sand", "default:silver_sand"},
    sidelen = 16,
    noise_params = {
        offset = 0,
        scale = 0.02,
        spread = {x = 200, y = 200, z = 200},
        seed = 329,
        octaves = 3,
        persist = 0.6
    },
    biomes = {"desert", "sandstone_desert", "cold_desert"},
    y_max = 31000,
    y_min = 2,
    decoration = "default:dry_shrub",
    param2 = 4,
})
]]--
