---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_coal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_coal.init()

    return {
        description = "Ordinary stone with coal as ore",
        depends = {"mineral_coal", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_coal.exec()

    unilib.register_node("unilib:stone_ordinary_with_coal", "default:stone_with_coal", mode, {
        -- From default:stone_with_coal
        description = unilib.utils.brackets(S("Coal Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_coal.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_coal_lump",
    })

end
