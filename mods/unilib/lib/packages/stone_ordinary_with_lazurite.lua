---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lazurite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lazurite.init()

    return {
        description = "Ordinary stone with lazurite as ore",
        depends = {"mineral_lazurite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_lazurite.exec()

    unilib.register_node(
        -- From real_minerals:lazurite_in_default_stone
        "unilib:stone_ordinary_with_lazurite",
        "real_minerals:lazurite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Lazurite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_lazurite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_lazurite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_lazurite_lump"}}
                }
            }
        }
    )

end
