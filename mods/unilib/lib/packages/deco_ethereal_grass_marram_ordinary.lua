---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_marram_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_marram_ordinary.init()

    return {
        description = "Ordinary marram grass as decoration (with ordinary grass as backup)",
        depends = {"grass_marram_ordinary",  "sand_ordinary"},
        at_least_one = {"biome_ethereal_forest_coniferous", "biome_ethereal_grassland"},
    }

end

function unilib.pkg.deco_ethereal_grass_marram_ordinary.exec()

    unilib.register_decoration_generic("ethereal_grass_marram_ordinary", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {
            "unilib:grass_marram_ordinary_1",
            "unilib:grass_marram_ordinary_2",
            "unilib:grass_marram_ordinary_3",
        },
        noise_params = {
            flags = "absvalue, eased",
            octaves = 1,
            offset = -0.7,
            persist = 0,
            scale = 3,
            seed = 513337,
            spread = {x = 16, y = 16, z = 16},
        },
        sidelen = 4,
    })

end

function unilib.pkg.deco_ethereal_grass_marram_ordinary.post()

    unilib.register_decoration_complete("ethereal_grass_marram_ordinary", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {"ethereal_forest_coniferous_dunes", "ethereal_grassland_ocean"},
        place_on = "unilib:sand_ordinary",
        y_max = 6,
        y_min = 3,
    })

end
