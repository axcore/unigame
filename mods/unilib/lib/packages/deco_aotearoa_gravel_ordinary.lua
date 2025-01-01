---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_gravel_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_gravel_ordinary.init()

    return {
        description = "Ordinary gravel as decoration",
        depends = "gravel_ordinary",
        at_least_one = {
            {"biome_aotearoa_alpine", "biome_aotearoa_shore"},
            {"stone_andesite_antipodean", "stone_schist_antipodean"},
        },
    }

end

function unilib.pkg.deco_aotearoa_gravel_ordinary.exec()

    unilib.register_decoration_generic("aotearoa_gravel_ordinary", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:gravel_ordinary",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.095,
            seed = 1100,
            spread = {x = 6, y = 6, z = 6},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_aotearoa_gravel_ordinary.post()

    unilib.register_decoration_complete("aotearoa_gravel_ordinary", nil, {
        -- From aotearoa/spawn_plants.lua
        biomes = {"aotearoa_alpine_fellfield", "aotearoa_shore_subantarctic"},
        place_on = {"unilib:stone_andesite_antipodean", "unilib:stone_schist_antipodean"},
        y_max = 140,
        y_min = -23,
    })

end
