---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_kaolinite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_kaolinite.init()

    return {
        description = "Ordinary stone with kaolinite as ore",
        depends = {"mineral_kaolinite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_kaolinite.exec()

    unilib.register_node(
        -- From real_minerals:kaolinite_in_default_stone
        "unilib:stone_ordinary_with_kaolinite",
        "real_minerals:kaolinite_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Kaolinite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_kaolinite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_kaolinite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_kaolinite_lump"}},
                },
            },
        }
    )

end
