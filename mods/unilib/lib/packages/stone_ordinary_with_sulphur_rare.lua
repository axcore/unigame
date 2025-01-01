---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_sulphur_rare = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_sulphur_rare.init()

    return {
        description = "Ordinary stone with rare sulphur as ore",
        depends = {"mineral_sulphur_rare", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_sulphur_rare.exec()

    unilib.register_node(
        -- From real_minerals:sulfur_in_stone
        "unilib:stone_ordinary_with_sulphur_rare",
        "real_minerals:sulfur_in_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Rare Sulphur Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_sulphur_rare.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_sulphur_rare_lump 3"}, rarity = 15},
                    {items = {"unilib:mineral_sulphur_rare_lump 2"}},
                },
            },
            paramtype = "light",
        }
    )

end
