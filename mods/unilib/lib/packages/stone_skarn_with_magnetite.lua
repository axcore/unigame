---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_skarn_with_magnetite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_skarn_with_magnetite.init()

    return {
        description = "Skarn with magnetite as ore",
        depends = {"mineral_magnetite", "stone_skarn"},
    }

end

function unilib.pkg.stone_skarn_with_magnetite.exec()

    unilib.register_node(
        -- From rocks, mineral:skarn_magnetite
        "unilib:stone_skarn_with_magnetite",
        "mineral:skarn_magnetite",
        mode,
        {
            description = unilib.utils.brackets(S("Magnetite Ore"), S("Skarn")),
            tiles = {"unilib_stone_skarn.png^unilib_mineral_magnetite_alt.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:mineral_magnetite_lump",
        }
    )

end
