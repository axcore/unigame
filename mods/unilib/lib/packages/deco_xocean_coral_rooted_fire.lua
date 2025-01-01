---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_xocean_coral_rooted_fire = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_xocean_coral_rooted_fire.init()

    return {
        description = "Rooted fire coral as decoration",
        depends = {"coral_rooted_fire", "shared_xocean"},
        at_least_one = {
            "biome_default_desert_cold",
            "biome_default_desert_sandstone",
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_grassland_snowy",
            "biome_default_taiga",
            "coral_block_bubble",
            "coral_block_fire",
            "coral_block_horn",
            "coral_block_rose",
            "coral_block_tube",
        },
    }

end

function unilib.pkg.deco_xocean_coral_rooted_fire.post()

    --[[
    unilib.register_decoration_complete("xocean_coral_rooted_fire", nil, {
        -- From xocean/init.lua
        -- Completes decoration in package "coral_rooted_fire"
        biomes = {
            "default_desert_cold_ocean",
            "default_desert_sandstone_ocean",
            "default_forest_coniferous_ocean",
            "default_forest_deciduous_ocean",
            "default_grassland_ocean",
            "default_grassland_snowy_ocean",
            "default_taiga_ocean",
        },
        place_on = {
            "unilib:coral_block_bubble",
            "unilib:coral_block_fire",
            "unilib:coral_block_horn",
            "unilib:coral_block_rose",
            "unilib:coral_block_tube",
        },
        y_max = -5,
        y_min = -50,
    })

    unilib.register_decoration_complete("xocean_coral_rooted_fire_skeleton", nil, {
        -- From xocean/init.lua
        -- Completes decoration in package "coral_rooted_fire"
        biomes = {
            "default_desert_cold_ocean",
            "default_desert_sandstone_ocean",
            "default_forest_coniferous_ocean",
            "default_forest_deciduous_ocean",
            "default_grassland_ocean",
            "default_grassland_snowy_ocean",
            "default_taiga_ocean",
        },
        place_on = {
            "unilib:coral_block_bubble",
            "unilib:coral_block_fire",
            "unilib:coral_block_horn",
            "unilib:coral_block_rose",
            "unilib:coral_block_tube",
        },
        y_max = -5,
        y_min = -50,
    })
    ]]--

    for _, part_name in pairs({"", "_skeleton"}) do

        unilib.register_decoration_complete("xocean_coral_rooted_fire" .. part_name, nil, {
            -- From xocean/init.lua
            -- Completes decoration in package "coral_rooted_tube"
            biomes = {
                "default_desert_cold_ocean",
                "default_desert_sandstone_ocean",
                "default_forest_coniferous_ocean",
                "default_forest_deciduous_ocean",
                "default_grassland_ocean",
                "default_grassland_snowy_ocean",
                "default_taiga_ocean",
            },
            place_on = {
                "unilib:coral_block_bubble",
                "unilib:coral_block_fire",
                "unilib:coral_block_horn",
                "unilib:coral_block_rose",
                "unilib:coral_block_tube",
            },
            y_max = -5,
            y_min = -50,
        })

    end

end
