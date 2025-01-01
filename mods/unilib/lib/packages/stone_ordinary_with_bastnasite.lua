---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_bastnasite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_bastnasite.init()

    return {
        description = "Ordinary stone with bastnasite as ore",
        depends = {"mineral_bastnasite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_bastnasite.exec()

    unilib.register_node("unilib:stone_ordinary_with_bastnasite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_bastnasite.png. Original code
        description = unilib.utils.brackets(S("Bastnasite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_bastnasite.png"},
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_bastnasite_lump",
    })

end
