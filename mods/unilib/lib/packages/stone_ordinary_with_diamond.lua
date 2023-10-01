---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_diamond.init()

    return {
        description = "Ordinary stone with diamond as ore",
        depends = {"mineral_diamond", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_diamond.exec()

    unilib.register_node("unilib:stone_ordinary_with_diamond", "default:stone_with_diamond", mode, {
        -- From default:stone_with_diamond
        description = unilib.brackets(S("Diamond Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_diamond.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_diamond_gem",
    })

end
