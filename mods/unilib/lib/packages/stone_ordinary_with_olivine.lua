---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_olivine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_olivine.init()

    return {
        description = "Ordinary stone with olivine as ore",
        depends = {"mineral_olivine", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_olivine.exec()

    unilib.register_node(
        -- From real_minerals:olivine_in_default_stone
        "unilib:stone_ordinary_with_olivine",
        "real_minerals:olivine_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Olivine Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_olivine.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_olivine_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_olivine_lump"}}
                }
            }
        }
    )

end
