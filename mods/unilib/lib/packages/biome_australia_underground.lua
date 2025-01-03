---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_underground = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_underground.init()

    return {
        description = "Australian Underground biome",
    }

end

function unilib.pkg.biome_australia_underground.post()

    unilib.register_biome({
        -- From australia/biome_underground.lua, "underground" biome
        name = "australia_underground",
        description = unilib.utils.brackets(S("Australian Underground biome"), "australia"),
        y_max = -65,
        y_min = unilib.constant.y_min,
        heat_point = 50,
        humidity_point = 50,
    })

end
