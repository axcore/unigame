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
local function register_dry_grass_decoration(offset, scale, length)
    minetest.register_decoration({
        name = "default:dry_grass_" .. length,
        deco_type = "simple",
        place_on = {"default:dry_dirt_with_dry_grass"},
        sidelen = 16,
        noise_params = {
            offset = offset,
            scale = scale,
            spread = {x = 200, y = 200, z = 200},
            seed = 329,
            octaves = 3,
            persist = 0.6
        },
        biomes = {"savanna"},
        y_max = 31000,
        y_min = 1,
        decoration = "default:dry_grass_" .. length,
    })
end

register_dry_grass_decoration(0.01, 0.05,  5)
register_dry_grass_decoration(0.03, 0.03,  4)
register_dry_grass_decoration(0.05, 0.01,  3)
register_dry_grass_decoration(0.07, -0.01, 2)
register_dry_grass_decoration(0.09, -0.03, 1)
]]--
