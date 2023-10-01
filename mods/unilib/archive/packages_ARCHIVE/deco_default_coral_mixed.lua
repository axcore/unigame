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
    name = "default:corals",
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
    y_min = -8,
    flags = "force_placement",
    decoration = {
        "default:coral_green", "default:coral_pink",
        "default:coral_cyan", "default:coral_brown",
        "default:coral_orange", "default:coral_skeleton",
    },
})
]]--
