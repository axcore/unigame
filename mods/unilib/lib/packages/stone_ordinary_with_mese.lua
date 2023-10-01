---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_mese.init()

    return {
        description = "Ordinary stone with mese crystals as ore",
        depends = {"mineral_mese", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_mese.exec()

    unilib.register_node("unilib:stone_ordinary_with_mese", "default:stone_with_mese", mode, {
        -- From default:stone_with_mese
        description = unilib.brackets(S("Mese Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_mese.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_mese_crystal",
    })

end
