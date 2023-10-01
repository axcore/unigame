---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_tetrahedrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_tetrahedrite.init()

    return {
        description = "Ordinary stone with tetrahedrite as ore",
        depends = {"mineral_tetrahedrite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_tetrahedrite.exec()

    unilib.register_node(
        -- From real_minerals:tetrahedrite_in_default_stone
        "unilib:stone_ordinary_with_tetrahedrite",
        "real_minerals:tetrahedrite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Tetrahedrite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_tetrahedrite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_tetrahedrite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_tetrahedrite_lump"}}
                }
            }
        }
    )

end
