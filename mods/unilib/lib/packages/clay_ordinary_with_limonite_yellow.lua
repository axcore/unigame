---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_ordinary_with_limonite_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_ordinary_with_limonite_yellow.init()

    return {
        description = "Ordinary clay with yellow limonite as ore",
        depends = {"clay_ordinary", "mineral_limonite_yellow"},
    }

end

function unilib.pkg.clay_ordinary_with_limonite_yellow.exec()

    unilib.register_node("unilib:clay_ordinary_with_limonite_yellow", nil, mode, {
        -- Texture from PFAA, weakOreClay_yellowLimonite.png. Original code
        description = unilib.utils.brackets(S("Yellow Limonite Ore"), S("Ordinary Clay")),
        tiles = {"unilib_clay_ordinary.png^unilib_mineral_limonite_yellow.png"},
        groups = {clay = 1, crumbly = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_limonite_yellow_lump",
    })

end
