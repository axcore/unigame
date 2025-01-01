---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_copper.init()

    return {
        description = "Ordinary stone with copper as ore",
        depends = {"metal_copper", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_copper.exec()

    unilib.register_node("unilib:stone_ordinary_with_copper", "default:stone_with_copper", mode, {
        -- From default:stone_with_copper
        description = unilib.utils.brackets(S("Copper Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_metal_copper.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:metal_copper_lump",
    })

end
