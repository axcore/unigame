---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_goldfields_esperance = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_goldfields_esperance.init()

    return {
        description = "Goldfields-Esperance biome",
        depends = {"dirt_ordinary", "sand_desert", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_australia_goldfields_esperance.post()

    unilib.register_biome({
        -- From australia/biome_goldfields_esperance.lua, "goldfields_esperance" biome
        name = "australia_goldfields_esperance",
        description = unilib.utils.brackets(S("Goldfields-Esperance biome"), "australia"),
        node_top = "unilib:sand_desert",
        depth_top = 2,
        node_filler = "unilib:stone_sandstone_ordinary",
        depth_filler = 2,
        node_river_water = "unilib:dirt_ordinary_with_turf_dry",
        y_max = 35,
        y_min = 4,
        heat_point = 60,
        humidity_point = 20,
    })

end
