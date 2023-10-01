---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_gold.init()

    return {
        description = "Ordinary stone with gold as ore",
        depends = {"metal_gold", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_gold.exec()

    unilib.register_node("unilib:stone_ordinary_with_gold", "default:stone_with_gold", mode, {
        -- From default:stone_with_gold
        description = unilib.brackets(S("Gold Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_metal_gold.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:metal_gold_lump",
    })

end
