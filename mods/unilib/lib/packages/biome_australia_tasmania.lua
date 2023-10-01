---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_tasmania = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_tasmania.init()

    return {
        description = "Tasmania biome",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.biome_australia_tasmania.exec()

    unilib.register_biome({
        -- From australia/biome_tasmania.lua, "tasmania" biome
        name = "australia_tasmania",
        description = unilib.brackets(S("Tasmania biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        y_max = unilib.y_max,
        y_min = 36,
        heat_point = 15,
        humidity_point = 85,
    })

end
