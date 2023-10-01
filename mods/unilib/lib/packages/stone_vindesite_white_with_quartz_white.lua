---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_vindesite_white_with_quartz_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_vindesite_white_with_quartz_white.init()

    return {
        description = "White vindesite with white quartz as ore",
        depends = {"mineral_quartz_white", "stone_vindesite_white"},
    }

end

function unilib.pkg.stone_vindesite_white_with_quartz_white.exec()

    unilib.register_node(
        -- From underch:vindesite_quartz_ore
        "unilib:stone_vindesite_white_with_quartz_white",
        "underch:vindesite_quartz_ore",
        mode,
        {
            description = unilib.brackets(S("White Quartz Ore"), S("White Vindesite")),
            tiles = {"unilib_stone_vindesite_white.png^unilib_mineral_quartz_white.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,

            drop = "unilib:mineral_quartz_white_crystal",
        }
    )

end
