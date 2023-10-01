---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_sylvite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_sylvite.init()

    return {
        description = "Ordinary stone with sylvite as ore",
        depends = {"mineral_sylvite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_sylvite.exec()

    unilib.register_node(
        -- From real_minerals:sylvite_in_default_stone
        "unilib:stone_ordinary_with_sylvite",
        "real_minerals:sylvite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Sylvite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_sylvite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_sylvite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_sylvite_lump"}}
                }
            }
        }
    )

end
