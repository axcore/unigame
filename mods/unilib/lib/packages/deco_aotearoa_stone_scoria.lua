---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_stone_scoria = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_stone_scoria.init()

    return {
        description = "Scoria as decoration",
        depends = {"biome_aotearoa_shore", "stone_scoria"},
    }

end

function unilib.pkg.deco_aotearoa_stone_scoria.post()

    unilib.register_decoration_complete("aotearoa_stone_scoria", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "stone_scoria"
        biomes = "aotearoa_shore_volcanic_field",
        place_on = "unilib:stone_scoria",
        y_max = 40,
        y_min = -23,
    })

end
