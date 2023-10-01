---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
for i = 1, 6 do
    local height = 5
    if i > 3 then height = 1 end
    register_seagrass({
        id = "decorations_sea:seagrass_0" .. i,
        description = "Seagrass",
        texture = "decorations_sea_seagrass_0" .. i .. ".png",
        max_height = height,
    })
end

local tall_grass_list = {
    {"decorations_sea:seagrass_02", 4, 7, grass_noise, warm_biomes},
    {"decorations_sea:seagrass_02", 3, 4, grass_noise, warm_biomes},
    {"decorations_sea:seagrass_02", 2, 2, grass_noise, warm_biomes},
}

local simple_decoration_list = {
    {"decorations_sea:seagrass_02", grass_noise, warm_biomes},
}
]]--
