---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_marram = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_marram.init()

    return {
        description = "Marram grass as decoration (with ordinary grass as backup)",
        depends = {"biome_ethereal_sand_clay", "sand_ordinary"},
        at_least_one = {"grass_marram", "grass_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_grass_marram.exec()

    if unilib.pkg_executed_table["grass_marram"] ~= nil then

        unilib.register_decoration("ethereal_grass_marram", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:grass_marram_1",
                "unilib:grass_marram_2",
                "unilib:grass_marram_3",
            },

            fill_ratio = 0.25,
            sidelen = 80,
        })

    elseif unilib.pkg_executed_table["grass_ordinary"] ~= nil then

        -- Failsafe, in case marram not available
        unilib.register_decoration("ethereal_grass_marram", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3"},

            fill_ratio = 0.25,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_grass_marram.post()

    unilib.register_decoration_now("ethereal_grass_marram", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_sand_clay",
        place_on = "unilib:sand_ordinary",
        y_max = 4,
        y_min = 3,
    })

end
