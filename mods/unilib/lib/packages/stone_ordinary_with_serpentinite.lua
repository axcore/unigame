---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_serpentinite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_serpentinite.init()

    return {
        description = "Ordinary stone with serpentinite as ore",
        depends = {"mineral_serpentinite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_serpentinite.exec()

    unilib.register_node(
        -- From real_minerals:serpentine_in_default_stone
        "unilib:stone_ordinary_with_serpentinite",
        "real_minerals:serpentine_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Serpentinite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_serpentinite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_serpentinite_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_serpentinite_lump"}}
                }
            }
        }
    )

end
