---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_aetherium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_aetherium.init()

    return {
        description = "Desert stone with aetherium as ore",
        depends = {"mineral_aetherium", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_aetherium.exec()

    unilib.register_node(
        -- From ethereal:etherium_ore
        "unilib:stone_desert_with_aetherium",
        "ethereal:etherium_ore",
        mode,
        {
            description = unilib.utils.brackets(S("Aetherium Ore"), S("Desert Stone")),
            tiles = {"unilib_stone_desert.png^unilib_mineral_aetherium.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:mineral_aetherium_dust",
        }
    )

end
