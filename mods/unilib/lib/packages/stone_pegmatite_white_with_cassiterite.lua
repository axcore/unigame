---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_pegmatite_white_with_cassiterite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_pegmatite_white_with_cassiterite.init()

    return {
        description = "White pegmatite with cassiterite as ore",
        depends = {"mineral_cassiterite", "stone_pegmatite_white"},
    }

end

function unilib.pkg.stone_pegmatite_white_with_cassiterite.exec()

    unilib.register_node(
        -- From rocks, mineral:pegmatite_cassiterite
        "unilib:stone_pegmatite_white_with_cassiterite",
        "mineral:pegmatite_cassiterite",
        mode,
        {
            description = unilib.brackets(S("Cassiterite Ore"), S("White Pegmatite")),
            tiles = {"unilib_stone_pegmatite_white.png^unilib_mineral_cassiterite_alt.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            drop = "unilib:mineral_cassiterite_lump",
        }
    )

end
