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
local plantlike_corals = {5, 7, 8, 1, 6}

for k,v in pairs(plantlike_corals) do
    minetest.register_node("decorations_sea:coral_plantlike_0" .. k, {
        description = "Coral",
        drawtype = "plantlike_rooted",
        paramtype2 = "meshoptions",
        place_param2 = 4,
        tiles = {"decorations_sea_coral_node_0" .. v .. ".png"},
        special_tiles = {{name = "decorations_sea_coral_0" .. k .. ".png", tileable_vertical = true}},
        inventory_image = "decorations_sea_coral_0" .. k .. ".png",
        paramtype = "light",
        groups = {cracky = 3},
        sounds = default.node_sound_stone_defaults({
            dig = {name = "default_dig_snappy", gain = 0.2},
            dug = {name = "default_grass_footstep", gain = 0.25},
        }),
    })
end

local simple_decoration_list = {
    {"decorations_sea:coral_plantlike_04", single_coral_noise, warm_biomes},
}
]]--
