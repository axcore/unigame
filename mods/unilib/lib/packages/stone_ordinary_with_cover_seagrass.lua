---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_cover_seagrass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_cover_seagrass.init()

    return {
        description = "Ordinary stone with seagrass",
        depends = "grass_seagrass",
    }

end

function unilib.pkg.stone_ordinary_with_cover_seagrass.exec()

    unilib.register_node(
        -- From farlands, mapgen:stone_with_sea_grass
        "unilib:stone_ordinary_with_cover_seagrass",
        "mapgen:stone_with_sea_grass",
        mode,
        {
            description = S("Ordinary Stone with Seagrass"),
            tiles = {
                "unilib_cover_seagrass_top.png",
                "unilib_stone_ordinary.png",
                {
                    name = "unilib_stone_ordinary.png^unilib_cover_seagrass_side.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.stone,

            drop = "unilib:grass_seagrass_1",
        }
    )

end
