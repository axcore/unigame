---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_iron.init()

    return {
        description = "Ordinary stone with iron as ore",
        depends = {"metal_iron", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_iron.exec()

    unilib.register_node("unilib:stone_ordinary_with_iron", "default:stone_with_iron", mode, {
        -- From default:stone_with_iron
        description = unilib.brackets(S("Iron Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_metal_iron.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:metal_iron_lump",
    })

end
