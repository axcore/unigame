---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_indian_ocean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_indian_ocean.init()

    return {
        description = "Indian Ocean biome",
        depends = {"sand_ordinary", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_australia_indian_ocean.post()

    unilib.register_biome({
        -- From australia/biome_indian_ocean.lua, "indian_ocean" biome
        name = "australia_indian_ocean",
        description = unilib.utils.brackets(S("Indian Ocean biome"), "australia"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:stone_sandstone_ordinary",
        depth_filler = 3,
        y_max = 3,
        y_min = -64,
        heat_point = 60,
        humidity_point = 50,
    })

end
