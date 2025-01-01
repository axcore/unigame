---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_limonite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_limonite.init()

    return {
        description = "Ordinary stone with limonite as ore",
        depends = {"mineral_limonite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_limonite.exec()

    unilib.register_node(
        -- From real_minerals:limonite_in_default_stone
        "unilib:stone_ordinary_with_limonite",
        "real_minerals:limonite_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Limonite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_limonite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_limonite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_limonite_lump"}},
                },
            },
        }
    )

end
