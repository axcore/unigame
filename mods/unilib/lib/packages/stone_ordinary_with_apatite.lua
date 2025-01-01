---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_apatite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_apatite.init()

    return {
        description = "Ordinary stone with apatite as ore",
        depends = {"mineral_apatite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_apatite.exec()

    unilib.register_node("unilib:stone_ordinary_with_apatite", nil, mode, {
        -- Texture from PFAA, strongOreRock_apatite.png. Original code
        description = unilib.utils.brackets(S("Apatite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_apatite.png"},
        groups = {cracky = 1, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_apatite_lump",
    })

end
