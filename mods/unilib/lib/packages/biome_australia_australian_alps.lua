---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_australian_alps = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_australian_alps.init()

    return {
        description = "Australian Alps biome",
        depends = {"dirt_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_australia_australian_alps.post()

    unilib.register_biome({
        -- From australia/biome_australian_alps.lua, "australian_alps" biome
        name = "australia_australian_alps",
        description = unilib.utils.brackets(S("Australian Alps biome"), "australia"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:snow_ordinary_block",
        depth_top = 2,
        node_filler = "unilib:dirt_ordinary_with_cover_snow",
        depth_filler = 1,
        y_max = unilib.constant.y_max,
        y_min = 150,
        heat_point = 10,
        humidity_point = 50,
    })

end
