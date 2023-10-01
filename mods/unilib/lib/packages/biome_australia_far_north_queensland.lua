---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_far_north_queensland = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_far_north_queensland.init()

    return {
        description = "Far North Queensland biome",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.biome_australia_far_north_queensland.exec()

    unilib.register_biome({
        -- From australia/biome_far_north_queensland.lua, "far_north_queensland" biome
        name = "australia_far_north_queensland",
        description = unilib.brackets(S("Far North Queensland biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        y_max = 35,
        y_min = 4,
        heat_point = 75,
        humidity_point = 90,
    })

end
