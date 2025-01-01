---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_copper_native = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_copper_native.init()

    return {
        description = "Desert stone with native copper as ore",
        depends = {"mineral_copper_native", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_copper_native.exec()

    unilib.register_node(
        -- From real_minerals:native_copper_in_default_stone
        "unilib:stone_desert_with_copper_native",
        "real_minerals:native_copper_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Native Copper"), S("Desert Stone")),
            tiles = {"unilib_stone_desert.png^unilib_mineral_copper_native.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:mineral_copper_native_lump 2"}, rarity = 2},
                    {items = {"unilib:mineral_copper_native_lump"}},
                },
            },
        }
    )

end
