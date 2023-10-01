---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_aloe_vera = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_aloe_vera.init()

    return {
        description = "Aloe vera as decoration",
        depends = {"biome_farlands_swamp", "plant_aloe_vera", "sand_desert"},
    }

end

function unilib.pkg.deco_farlands_plant_aloe_vera.post()

    unilib.register_decoration_now("farlands_plant_aloe_vera", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_aloe_vera"
        biomes = "farlands_swamp",
        place_on = "unilib:sand_desert",
    })

end
