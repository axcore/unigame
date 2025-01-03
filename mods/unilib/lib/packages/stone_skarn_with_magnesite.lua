---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_skarn_with_magnesite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_skarn_with_magnesite.init()

    return {
        description = "Skarn with magnesite as ore",
        depends = {"mineral_magnesite", "stone_skarn"},
    }

end

function unilib.pkg.stone_skarn_with_magnesite.exec()

    unilib.register_node(
        -- From rocks, mineral:skarn_magnesite
        "unilib:stone_skarn_with_magnesite",
        "mineral:skarn_magnesite",
        mode,
        {
            description = unilib.utils.brackets(S("Magnesite Ore"), S("Skarn")),
            tiles = {"unilib_stone_skarn.png^unilib_mineral_magnesite_alt.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:mineral_magnesite_lump",
        }
    )

end
