---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_barite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_barite.init()

    return {
        description = "Ordinary stone with barite as ore",
        depends = {"mineral_barite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_barite.exec()

    unilib.register_node("unilib:stone_ordinary_with_barite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_barite.png. Original code
        description = unilib.utils.brackets(S("Barite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_barite.png"},
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_barite_lump",
    })

end
