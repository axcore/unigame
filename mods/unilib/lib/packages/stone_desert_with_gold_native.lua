---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_gold_native = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_gold_native.init()

    return {
        description = "Desert stone with native gold as ore",
        depends = {"mineral_gold_native", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_gold_native.exec()

    unilib.register_node(
        -- From real_minerals:native_gold_in_default_stone
        "unilib:stone_desert_with_gold_native",
        "real_minerals:native_gold_in_default_stone",
        mode,
        {
            description = unilib.brackets(S("Native Gold"), S("Desert Stone")),
            tiles = {"unilib_stone_desert.png^unilib_mineral_gold_native.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_gold_native_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_gold_native_lump"}}
                }
            }
        }
    )

end
