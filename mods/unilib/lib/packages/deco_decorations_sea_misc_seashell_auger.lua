---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_decorations_sea_misc_seashell_auger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_decorations_sea_misc_seashell_auger.init()

    return {
        description = "Auger seashell as decoration",
        depends = {"liquid_water_ordinary", "misc_seashell_auger", "sand_ordinary"},
    }

end

function unilib.pkg.deco_decorations_sea_misc_seashell_auger.post()

    unilib.register_decoration_complete("decoration_sea_misc_seashell_auger_1", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "misc_seashell_auger"
        biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 1,
        y_min = -32,
    })

    unilib.register_decoration_complete("decoration_sea_misc_seashell_auger_2", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "misc_seashell_auger"
        biomes = unilib.pkg.shared_decorations_sea.temperate_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 1,
        y_min = -32,
    })

end
