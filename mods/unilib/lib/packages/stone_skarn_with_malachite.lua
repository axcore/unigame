---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_skarn_with_malachite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_skarn_with_malachite.init()

    return {
        description = "Skarn with malachite as ore",
        depends = {"mineral_malachite", "stone_skarn"},
    }

end

function unilib.pkg.stone_skarn_with_malachite.exec()

    unilib.register_node(
        -- From rocks, mineral:skarn_malachyte
        "unilib:stone_skarn_with_malachite",
        "mineral:skarn_malachyte",
        mode,
        {
            description = unilib.utils.brackets(S("Malachite Ore"), S("Skarn")),
            -- (N.B. rocks does not provide a separate overlay for malachite, for some reason)
            tiles = {"unilib_stone_skarn.png^unilib_mineral_malachite.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:mineral_malachite_lump",
        }
    )

end
