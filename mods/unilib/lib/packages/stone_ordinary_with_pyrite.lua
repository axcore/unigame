---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_pyrite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_pyrite.init()

    return {
        description = "Ordinary stone with pyrite as ore",
        depends = {"mineral_pyrite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_pyrite.exec()

    unilib.register_node("unilib:stone_ordinary_with_pyrite", nil, mode, {
        -- Texture from PFAA, strongOreRock_pyrite.png. Original code
        description = unilib.utils.brackets(S("Pyrite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_pyrite.png"},
        groups = {cracky = 1, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_pyrite_lump",
    })

end
