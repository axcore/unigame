---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_pollucite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_pollucite.init()

    return {
        description = "Ordinary stone with pollucite as ore",
        depends = {"mineral_pollucite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_pollucite.exec()

    unilib.register_node("unilib:stone_ordinary_with_pollucite", nil, mode, {
        -- Texture from PFAA, strongOreRock_pollucite.png. Original code
        description = unilib.utils.brackets(S("Pollucite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_pollucite.png"},
        groups = {cracky = 1, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_pollucite_lump",
    })

end
