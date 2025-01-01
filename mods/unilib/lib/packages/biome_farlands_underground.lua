---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_underground = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_underground.init()

    return {
        description = "Underground biome",
    }

end

function unilib.pkg.biome_farlands_underground.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "underground" biome
        name = "farlands_underground",
        description = unilib.utils.brackets(S("Underground biome"), "farlands"),
        y_max = -113,
        y_min = unilib.constant.y_min,
        heat_point = 50,
        humidity_point = 50,
    })

end
