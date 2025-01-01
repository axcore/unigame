---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_magnetite_vanadium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_magnetite_vanadium.init()

    return {
        description = "Ordinary stone with vanadium magnetite as ore",
        depends = {"mineral_magnetite_vanadium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_magnetite_vanadium.exec()

    unilib.register_node("unilib:stone_ordinary_with_magnetite_vanadium", nil, mode, {
        -- Texture from PFAA, strongOreRock_vanadiumMagnetite.png. Original code
        description = unilib.utils.brackets(S("Vanadium Magnetite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_magnetite_vanadium.png"},
        groups = {cracky = 1, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_magnetite_vanadium_lump",
    })

end
