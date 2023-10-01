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

local simple_decoration_list = {
    {"decorations_sea:seagrass_05", short_grass_noise, warm_biomes},
}
]]--
