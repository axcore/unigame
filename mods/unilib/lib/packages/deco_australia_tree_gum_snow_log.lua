---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_gum_snow_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_gum_snow_log.init()

    return {
        description = "Snow gum tree log as decoration",
        depends = {
            "biome_australia_australian_alps",
            "mushroom_brown",
            "snow_ordinary",
            "tree_gum_snow",
        },
    }

end

function unilib.pkg.deco_australia_tree_gum_snow_log.post()

    unilib.register_decoration_complete("australia_tree_gum_snow_log", nil, {
        -- From australia/biome_australian_alps.lua
        biomes = "australia_australian_alps",
        place_on = "unilib:snow_ordinary_block",
        y_max = 170,
        y_min = 150,
    })

end
