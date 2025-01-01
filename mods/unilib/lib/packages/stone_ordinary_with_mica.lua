---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_mica = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_mica.init()

    return {
        description = "Ordinary stone with mica as ore",
        depends = {"mineral_mica", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_mica.exec()

    unilib.register_node("unilib:stone_ordinary_with_mica", nil, mode, {
        -- Texture from PFAA, weakOreRock_mica.png. Original code
        description = unilib.utils.brackets(S("Mica Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_mica.png"},
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_mica_lump",
    })

end
