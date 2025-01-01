---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_great_australian_bight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_great_australian_bight.init()

    return {
        description = "Great Australian Bight biome",
        depends = "stone_sandstone_ordinary",
    }

end

function unilib.pkg.biome_australia_great_australian_bight.post()

    unilib.register_biome({
        -- From australia/biome_great_australian_bight.lua, "great_australian_bight" biome
        name = "australia_great_australian_bight",
        description = unilib.utils.brackets(S("Great Australian Bight biome"), "australia"),
        node_top = "unilib:stone_sandstone_ordinary",
        depth_top = 1,
        node_filler = "unilib:stone_sandstone_ordinary",
        depth_filler = 3,
        y_max = 3,
        y_min = -64,
        heat_point = 40,
        humidity_point = 50,
    })

end
