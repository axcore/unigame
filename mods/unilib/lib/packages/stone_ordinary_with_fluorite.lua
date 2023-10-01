---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_fluorite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_fluorite.init()

    return {
        description = "Ordinary stone with fluorite as ore",
        depends = {"mineral_fluorite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_fluorite.exec()

    unilib.register_node("unilib:stone_ordinary_with_fluorite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_fluorite.png. Original code
        description = unilib.brackets(S("Fluorite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_fluorite.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_fluorite_lump",
    })

end
