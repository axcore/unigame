---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_stibnite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_stibnite.init()

    return {
        description = "Ordinary stone with stibnite as ore",
        depends = {"mineral_stibnite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_stibnite.exec()

    unilib.register_node("unilib:stone_ordinary_with_stibnite", nil, mode, {
        -- Texture from PFAA, weakOreRock_stibnite.png. Original code
        description = unilib.utils.brackets(S("Stibnite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_stibnite.png"},
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_stibnite_lump",
    })

end

