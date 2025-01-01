---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_iron_banded = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_iron_banded.init()

    return {
        description = "Ordinary stone with banded iron as ore",
        depends = {"metal_iron", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_iron_banded.exec()

    unilib.register_node("unilib:stone_ordinary_with_iron_banded", nil, mode, {
        -- Texture from PFAA, strongOreRock_bandedIron.png. Original code
        description = unilib.utils.brackets(S("Banded Iron Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_iron_banded.png"},
        groups = {cracky = 1, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:metal_iron_lump",
    })

end
