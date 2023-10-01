---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_bauxite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_bauxite.init()

    return {
        description = "Ordinary stone with bauxite as ore",
        depends = {"mineral_bauxite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_bauxite.exec()

    unilib.register_node(
        -- From real_minerals:bauxite_in_default_stone
        "unilib:stone_ordinary_with_bauxite",
        "real_minerals:bauxite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Bauxite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_bauxite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_bauxite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_bauxite_lump"}}
                }
            }
        }
    )

end
