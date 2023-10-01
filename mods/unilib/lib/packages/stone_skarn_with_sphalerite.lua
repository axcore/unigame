---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_skarn_with_sphalerite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_skarn_with_sphalerite.init()

    return {
        description = "Skarn with sphalerite as ore",
        depends = {"mineral_sphalerite", "stone_skarn"},
    }

end

function unilib.pkg.stone_skarn_with_sphalerite.exec()

    unilib.register_node(
        -- From rocks, mineral:skarn_sphalerite
        "unilib:stone_skarn_with_sphalerite",
        "mineral:skarn_sphalerite",
        mode,
        {
            description = unilib.brackets(S("Sphalerite Ore"), S("Skarn")),
            tiles = {"unilib_stone_skarn.png^unilib_mineral_sphalerite_alt.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            drop = "unilib:mineral_sphalerite_lump",
        }
    )

end
