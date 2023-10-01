---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_decorations_sea_plant_seagrass_ribbon_serrated = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_decorations_sea_plant_seagrass_ribbon_serrated.init()

    return {
        description = "Serrated ribbon seagrass as decoration",
        depends = {"liquid_water_ordinary", "plant_seagrass_ribbon_serrated", "sand_ordinary"},
    }

end

function unilib.pkg.deco_decorations_sea_plant_seagrass_ribbon_serrated.post()

    unilib.register_decoration_now("decoration_sea_plant_seagrass_ribbon_serrated_1", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "plant_seagrass_ribbon_serrated"
        biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = -1,
        y_min = -32,
    })

end
