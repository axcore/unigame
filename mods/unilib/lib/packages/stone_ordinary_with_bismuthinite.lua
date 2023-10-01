---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_bismuthinite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_bismuthinite.init()

    return {
        description = "Ordinary stone with bismuthinite as ore",
        depends = {"mineral_bismuthinite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_bismuthinite.exec()

    unilib.register_node(
        -- From real_minerals:bismuthinite_in_default_stone
        "unilib:stone_ordinary_with_bismuthinite",
        "real_minerals:bismuthinite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Bismuthinite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_bismuthinite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_bismuthinite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_bismuthinite_lump"}}
                }
            }
        }
    )

end
