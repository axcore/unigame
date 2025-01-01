---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_cinnabar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_cinnabar.init()

    return {
        description = "Ordinary stone with cinnabar as ore",
        depends = {"mineral_cinnabar", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_cinnabar.exec()

    unilib.register_node(
        -- From real_minerals:cinnabar_in_default_stone
        "unilib:stone_ordinary_with_cinnabar",
        "real_minerals:cinnabar_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Cinnabar Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_cinnabar.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_cinnabar_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_cinnabar_lump"}},
                },
            },
        }
    )

end
