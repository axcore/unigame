---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_pentlandite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_pentlandite.init()

    return {
        description = "Ordinary stone with pentlandite as ore",
        depends = {"mineral_pentlandite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_pentlandite.exec()

    unilib.register_node("unilib:stone_ordinary_with_pentlandite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_pentlandite.png. Original code
        description = unilib.brackets(S("Pentlandite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_pentlandite.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_pentlandite_lump",
    })

end
