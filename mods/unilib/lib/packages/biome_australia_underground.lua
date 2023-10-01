---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_underground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_underground.init()

    return {
        description = "Australian underground biome",
    }

end

function unilib.pkg.biome_australia_underground.exec()

    unilib.register_biome({
        -- From australia/biome_underground.lua, "underground" biome
        name = "australia_underground",
        description = unilib.brackets(S("Underground biome"), "australia"),
        y_max = -65,
        y_min = unilib.y_min,
        heat_point = 50,
        humidity_point = 50,
    })

end
