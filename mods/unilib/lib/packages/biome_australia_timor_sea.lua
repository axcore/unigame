---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_timor_sea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_timor_sea.init()

    return {
        description = "Timor sea biome",
        depends = "sand_ordinary",
    }

end

function unilib.pkg.biome_australia_timor_sea.exec()

    unilib.register_biome({
        -- From australia/biome_timor_sea.lua, "timor_sea" biome
        name = "australia_timor_sea",
        description = unilib.brackets(S("Timor sea biome"), "australia"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        y_max = 3,
        y_min = -64,
        heat_point = 80,
        humidity_point = 90,
    })

end
