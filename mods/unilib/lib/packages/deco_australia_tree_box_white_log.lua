---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_box_white_log = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_box_white_log.init()

    return {
        description = "White box tree log as decoration",
        depends = {
            "biome_australia_victorian_forests",
            "dirt_ordinary",
            "mushroom_brown",
            "tree_box_white",
        },
    }

end

function unilib.pkg.deco_australia_tree_box_white_log.exec()

    unilib.register_decoration_now("australia_tree_box_white_log", nil, {
        -- From australia/biome_victorian_forests.lua
        biomes = "australia_victorian_forests",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 175,
        y_min = 36,
    })

end
