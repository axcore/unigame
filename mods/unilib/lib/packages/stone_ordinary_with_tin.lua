---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_tin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_tin.init()

    return {
        description = "Ordinary stone with tin as ore",
        depends = {"metal_tin", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_tin.exec()

    unilib.register_node(
        -- From default:stone_with_tin
        "unilib:stone_ordinary_with_tin",
        {"default:stone_with_tin", "moreores:mineral_tin"},
        mode,
        {
            description = unilib.brackets(S("Tin Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_tin.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,

            drop = "unilib:metal_tin_lump",
        }
    )

end

