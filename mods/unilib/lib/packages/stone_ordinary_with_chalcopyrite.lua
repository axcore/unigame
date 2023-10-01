---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_chalcopyrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_chalcopyrite.init()

    return {
        description = "Ordinary stone with chalcopyrite as ore",
        depends = {"mineral_chalcopyrite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_chalcopyrite.exec()

    unilib.register_node("unilib:stone_ordinary_with_chalcopyrite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_chalcopyrite.png. Original code
        description = unilib.brackets(S("Chalcopyrite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_chalcopyrite.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_chalcopyrite_lump",
    })

end
