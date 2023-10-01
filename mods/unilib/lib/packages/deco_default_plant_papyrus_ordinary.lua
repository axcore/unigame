---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_plant_papyrus_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_plant_papyrus_ordinary.init()

    return {
        description = "Ordinary papyrus as decoration",
        depends = "plant_papyrus_ordinary",
        optional = {
            "biome_default_rainforest",
            "biome_default_savanna",
            "dirt_ordinary",
            "dirt_dry",
        },
    }

end

function unilib.pkg.deco_default_plant_papyrus_ordinary.post()

    if unilib.pkg_executed_table["biome_default_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("default_plant_papyrus_ordinary_1", nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "plant_papyrus_ordinary"
            biomes = "default_rainforest_swamp",
            place_on = "unilib:dirt_ordinary",
            y_max = 0,
            y_min = 0,
        })

    end

    if unilib.pkg_executed_table["biome_default_savanna"] ~= nil and
            unilib.pkg_executed_table["dirt_dry"] ~= nil then

        unilib.register_decoration_now("default_plant_papyrus_ordinary_2", nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "plant_papyrus_ordinary"
            biomes = "default_savanna_shore",
            place_on = "unilib:dirt_dry",
            y_max = 0,
            y_min = 0,
        })

    end

end
