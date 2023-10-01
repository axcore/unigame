---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_sulphur_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_sulphur_real.init()

    return {
        description = "Ordinary stone with real sulphur as ore",
        depends = {"mineral_sulphur_real", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_sulphur_real.exec()

    unilib.register_node(
        -- From real_minerals:sulfur_in_stone
        "unilib:stone_ordinary_with_sulphur_real",
        "real_minerals:sulfur_in_stone",
        mode,
        {
            description = unilib.brackets(S("Real Sulphur Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_sulphur_real.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_sulphur_real_lump 3"}, rarity = 15},
                    {items = {"unilib:mineral_sulphur_real_lump 2"}}
                }
            },
            paramtype = "light",
        }
    )

end
