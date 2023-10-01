---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_mangroves = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_mangroves.init()

    return {
        description = "Mangrove biome",
        depends = {"clay_ordinary", "dirt_mud_mangrove", "liquid_water_river_muddy"},
    }

end

function unilib.pkg.biome_australia_mangroves.exec()

    unilib.register_biome({
        -- From australia/biome_mangroves.lua, "mangroves" biome
        name = "australia_mangroves",
        description = unilib.brackets(S("Mangrove biome"), "australia"),
        node_top = "unilib:dirt_mud_mangrove",
        depth_top = 3,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 1,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 3,
        y_min = -2,
        heat_point = 80,
        humidity_point = 80,
    })

end
