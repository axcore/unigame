---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_papyrus_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_papyrus_ordinary.init()

    return {
        description = "Ordinary papyrus as decoration",
        depends = {"biome_farlands_savanna", "dirt_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.deco_farlands_plant_papyrus_ordinary.exec()

    unilib.register_decoration_generic("farlands_plant_papyrus_ordinary", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_papyrus_ordinary_farlands.mts",

        noise_params = {
            octaves = 3,
            offset = -0.3,
            persist = 0.7,
            scale = 0.7,
            seed = 354,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_farlands_plant_papyrus_ordinary.post()

    unilib.register_decoration_complete("farlands_plant_papyrus_ordinary", nil, {
        -- From farlands, mapgen/mapgen.lua
        biomes = "farlands_savanna_shore",
        place_on = "unilib:dirt_ordinary",
        y_max = 0,
        y_min = 0,
    })

end
