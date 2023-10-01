---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_steatite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_steatite.init()

    return {
        description = "Ordinary stone with steatite as ore",
        depends = {"mineral_steatite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_steatite.exec()

    unilib.register_node("unilib:stone_ordinary_with_steatite", nil, mode, {
        -- Texture from PFAA, weakOreRock_soapstone.png. Original code
        description = unilib.brackets(S("Steatite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_steatite.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_steatite_lump",
    })

end
