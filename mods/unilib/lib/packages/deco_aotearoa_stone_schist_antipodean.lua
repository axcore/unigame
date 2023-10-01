---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_stone_schist_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_stone_schist_antipodean.init()

    return {
        description = "Antipodean schist as decoration",
        depends = {"biome_aotearoa_alpine", "stone_schist_antipodean"},
    }

end

function unilib.pkg.deco_aotearoa_stone_schist_antipodean.post()

    unilib.register_decoration_now("aotearoa_stone_schist_antipodean", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "stone_schist_antipodean"
        biomes = "aotearoa_alpine_fellfield",
        place_on = "unilib:stone_schist_antipodean",
        y_max = 140,
        y_min = 118,
    })

end
