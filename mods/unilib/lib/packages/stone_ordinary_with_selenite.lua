---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_selenite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_selenite.init()

    return {
        description = "Ordinary stone with selenite as ore",
        depends = {"mineral_selenite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_selenite.exec()

    unilib.register_node(
        -- From real_minerals:selenite_in_default_stone
        "unilib:stone_ordinary_with_selenite",
        "real_minerals:selenite_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Selenite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_selenite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_selenite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_selenite_lump"}}
                }
            }
        }
    )

end
