---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_wolframite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_wolframite.init()

    return {
        description = "Ordinary stone with wolframite as ore",
        depends = {"mineral_wolframite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_wolframite.exec()

    unilib.register_node("unilib:stone_ordinary_with_wolframite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_wolframite.png. Original code
        description = unilib.brackets(S("Wolframite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_wolframite.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_wolframite_lump",
    })

end
