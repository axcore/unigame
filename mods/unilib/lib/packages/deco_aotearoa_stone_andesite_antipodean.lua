---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_stone_andesite_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_stone_andesite_antipodean.init()

    return {
        description = "Antipodean andesite as decoration",
        depends = "stone_andesite_antipodean",
        at_least_one = {"biome_aotearoa_dunes", "biome_aotearoa_shore"},
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.deco_aotearoa_stone_andesite_antipodean.post()

    unilib.register_decoration_now("aotearoa_stone_andesite_antipodean", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "stone_andesite_antipodean"
        biomes = {"aotearoa_dunes_subantarctic_coast", "aotearoa_shore_subantarctic"},
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:stone_andesite_antipodean"},
        y_max = 14,
        y_min = -23,
    })

end
