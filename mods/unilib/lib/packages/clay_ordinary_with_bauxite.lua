---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_ordinary_with_bauxite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_ordinary_with_bauxite.init()

    return {
        description = "Ordinary clay with bauxite as ore",
        depends = {"clay_ordinary", "mineral_bauxite"},
    }

end

function unilib.pkg.clay_ordinary_with_bauxite.exec()

    unilib.register_node("unilib:clay_ordinary_with_bauxite", nil, mode, {
        -- Texture from real_minerals. Original code
        description = unilib.utils.brackets(S("Bauxite Ore"), S("Ordinary Clay")),
        tiles = {"unilib_clay_ordinary.png^unilib_mineral_bauxite.png"},
        groups = {clay = 1, crumbly = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_bauxite_lump",
    })

end
