---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_pyrolusite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_pyrolusite.init()

    return {
        description = "Ordinary stone with pyrolusite as ore",
        depends = {"mineral_pyrolusite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_pyrolusite.exec()

    unilib.register_node("unilib:stone_ordinary_with_pyrolusite", nil, mode, {
        -- Texture from PFAA, weakOreRock_pyrolusite.png. Original code
        description = unilib.brackets(S("Pyrolusite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_pyrolusite.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_pyrolusite_lump",
    })

end
