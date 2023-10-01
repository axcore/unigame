---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_ilmenite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_ilmenite.init()

    return {
        description = "Ordinary stone with ilmenite as ore",
        depends = {"mineral_ilmenite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_ilmenite.exec()

    unilib.register_node("unilib:stone_ordinary_with_ilmenite", nil, mode, {
        -- Texture from PFAA, strongOreRock_ilmenite.png. Original code
        description = unilib.brackets(S("Ilmenite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_ilmenite.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_ilmenite_lump",
    })

end
