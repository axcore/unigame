---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_weed_bindweed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_weed_bindweed.init()

    return {
        description = "Bindweed as decoration",
        depends = {"biome_farlands_forest_deciduous", "dirt_ordinary", "plant_weed_bindweed"},
    }

end

function unilib.pkg.deco_farlands_plant_weed_bindweed.post()

    unilib.register_decoration_complete("farlands_plant_weed_bindweed", nil, {
        -- farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_weed_bindweed"
        biomes = "farlands_forest_deciduous_tall",
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
