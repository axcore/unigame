---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_jet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_jet.init()

    return {
        description = "Ordinary stone with jet as ore",
        depends = {"mineral_jet", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_jet.exec()

    unilib.register_node(
        -- From real_minerals:jet_in_default_stone
        "unilib:stone_ordinary_with_jet",
        "real_minerals:jet_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Jet Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_jet.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_jet_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_jet_lump"}},
                },
            },
        }
    )

end
