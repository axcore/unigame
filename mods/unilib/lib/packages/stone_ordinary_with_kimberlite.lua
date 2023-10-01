---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_kimberlite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_kimberlite.init()

    return {
        description = "Ordinary stone with kimberlite as ore",
        depends = {"mineral_kimberlite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_kimberlite.exec()

    unilib.register_node(
        -- From real_minerals:kimberlite_in_default_stone
        "unilib:stone_ordinary_with_kimberlite",
        "real_minerals:kimberlite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Kimberlite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_kimberlite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_kimberlite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_kimberlite_lump"}}
                }
            }
        }
    )

end
