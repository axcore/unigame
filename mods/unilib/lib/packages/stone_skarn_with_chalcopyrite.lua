---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_skarn_with_chalcopyrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_skarn_with_chalcopyrite.init()

    return {
        description = "Skarn with chalcopyrite as ore",
        depends = {"mineral_chalcopyrite", "stone_skarn"},
    }

end

function unilib.pkg.stone_skarn_with_chalcopyrite.exec()

    unilib.register_node(
        -- From rocks, mineral:skarn_chalcopyrite
        "unilib:stone_skarn_with_chalcopyrite",
        "mineral:skarn_chalcopyrite",
        mode,
        {
            description = unilib.brackets(S("Chalcopyrite Ore"), S("Skarn")),
            tiles = {"unilib_stone_skarn.png^unilib_mineral_chalcopyrite_alt.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            drop = "unilib:mineral_chalcopyrite_lump",
        }
    )

end
