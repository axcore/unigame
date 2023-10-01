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
-- Jungle tree
minetest.register_decoration({
    name = "default:jungle_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_rainforest_litter"},
    sidelen = 80,
    fill_ratio = 0.1,
    biomes = {"rainforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/jungle_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})

-- Emergent jungle tree
-- Due to 32 node height, altitude is limited and prescence depends on chunksize
local chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
if chunksize >= 5 then
    minetest.register_decoration({
        name = "default:emergent_jungle_tree",
        deco_type = "schematic",
        place_on = {"default:dirt_with_rainforest_litter"},
        sidelen = 80,
        noise_params = {
            offset = 0.0,
            scale = 0.0025,
            spread = {x = 250, y = 250, z = 250},
            seed = 2685,
            octaves = 3,
            persist = 0.7
        },
        biomes = {"rainforest"},
        y_max = 32,
        y_min = 1,
        schematic = minetest.get_modpath("default") ..
                "/schematics/emergent_jungle_tree.mts",
        flags = "place_center_x, place_center_z",
        rotation = "random",
        place_offset_y = -4,
    })
end

-- Swamp jungle trees
minetest.register_decoration({
    name = "default:jungle_tree(swamp)",
    deco_type = "schematic",
    place_on = {"default:dirt"},
    sidelen = 16,
    -- Noise tuned to place swamp trees where papyrus is absent
    noise_params = {
        offset = 0.0,
        scale = -0.1,
        spread = {x = 200, y = 200, z = 200},
        seed = 354,
        octaves = 1,
        persist = 0.5
    },
    biomes = {"rainforest_swamp"},
    y_max = 0,
    y_min = -1,
    schematic = minetest.get_modpath("default") .. "/schematics/jungle_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})
]]--
