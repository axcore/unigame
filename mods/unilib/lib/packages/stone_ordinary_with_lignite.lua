---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lignite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lignite.init()

    return {
        description = "Ordinary stone with lignite as ore",
        depends = {"mineral_lignite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_lignite.exec()

    unilib.register_node(
        -- From real_minerals:lignite_in_default_stone
        "unilib:stone_ordinary_with_lignite",
        "real_minerals:lignite_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Lignite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_lignite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_lignite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_lignite_lump"}},
                },
            },
        }
    )

end
