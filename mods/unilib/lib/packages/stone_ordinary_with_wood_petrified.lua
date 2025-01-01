---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_wood_petrified = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_wood_petrified.init()

    return {
        description = "Ordinary stone with petrified wood as ore",
        depends = {"mineral_wood_petrified", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_wood_petrified.exec()

    unilib.register_node(
        -- From real_minerals:petrified_wood_in_default_stone
        "unilib:stone_ordinary_with_wood_petrified",
        "real_minerals:petrified_wood_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Petrified Wood Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_wood_petrified.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_wood_petrified_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_wood_petrified_lump"}},
                },
            },
        }
    )

end
