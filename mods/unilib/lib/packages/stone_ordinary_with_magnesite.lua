---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_magnesite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_magnesite.init()

    return {
        description = "Ordinary stone with magnesite as ore",
        depends = {"mineral_magnesite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_magnesite.exec()

    unilib.register_node("unilib:stone_ordinary_with_magnesite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_magnesite.png. Original code
        description = unilib.brackets(S("Magnesite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_magnesite.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_magnesite_lump",
    })

end
