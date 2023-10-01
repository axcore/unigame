---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_snow_plant_shrub_frozen = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_snow_plant_shrub_frozen.init()

    return {
        description = "Frozen shrub as decoration",
        depends = {"dirt_ordinary", "plant_shrub_frozen"},
        at_least_one = {"biome_snow_forest", "biome_snow_lush", "biome_snow_normal"},
    }

end

function unilib.pkg.deco_snow_plant_shrub_frozen.post()

    -- N.B. Original code placed dry shrubs as decorations, rather than frozen shrubs, for no
    --      obvious reason

    if unilib.pkg_executed_table["biome_snow_normal"] ~= nil then

        unilib.register_decoration_now("snow_plant_shrub_frozen", nil, {
            -- From snow/mapgen_v7.lua
            -- Completes the decoration in "plant_shrub_frozen"
            biomes = "snow_normal",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
        })

    end

    if unilib.pkg_executed_table["biome_snow_forest"] ~= nil or
            unilib.pkg_executed_table["biome_snow_lush"] ~= nil then

        unilib.register_decoration_now("snow_plant_shrub_frozen_covered", nil, {
            -- From snow/mapgen_v7.lua
            -- Completes the decoration in "plant_shrub_frozen"
            biomes = {"snow_forest", "snow_lush"},
            place_on = "unilib:dirt_ordinary_with_cover_snow",
        })

    end

end
