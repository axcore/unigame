---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_tantalite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_tantalite.init()

    return {
        description = "Ordinary stone with tantalite as ore",
        depends = {"mineral_tantalite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_tantalite.exec()

    unilib.register_node("unilib:stone_ordinary_with_tantalite", nil, mode, {
        -- Texture from PFAA, strongOreRock_tantalite.png. Original code
        description = unilib.brackets(S("Tantalite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_tantalite.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_tantalite_lump",
    })

end
