---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_scheelite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_scheelite.init()

    return {
        description = "Ordinary stone with scheelite as ore",
        depends = {"mineral_scheelite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_scheelite.exec()

    unilib.register_node("unilib:stone_ordinary_with_scheelite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_scheelite.png. Original code
        description = unilib.utils.brackets(S("Scheelite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_scheelite.png"},
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_scheelite_lump",
    })

end
