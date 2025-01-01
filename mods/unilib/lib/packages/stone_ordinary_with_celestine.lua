---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_celestine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_celestine.init()

    return {
        description = "Ordinary stone with celestine as ore",
        depends = {"mineral_celestine", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_celestine.exec()

    unilib.register_node("unilib:stone_ordinary_with_celestine", nil, mode, {
        -- Texture from PFAA, mediumOreRock_celestine.png. Original code
        description = unilib.utils.brackets(S("Celestine Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_celestine.png"},
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_celestine_lump",
    })

end
