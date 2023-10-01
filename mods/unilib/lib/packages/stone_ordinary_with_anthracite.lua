---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_anthracite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_anthracite.init()

    return {
        description = "Ordinary stone with anthracite as ore",
        depends = {"mineral_anthracite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_anthracite.exec()

    unilib.register_node(
        -- From real_minerals:anthracite_in_default_stone
        "unilib:stone_ordinary_with_anthracite",
        "real_minerals:anthracite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Anthracite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_anthracite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_anthracite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_anthracite_lump"}}
                }
            }
        }
    )

end
