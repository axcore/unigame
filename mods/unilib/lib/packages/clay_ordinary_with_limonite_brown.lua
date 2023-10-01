---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_ordinary_with_limonite_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_ordinary_with_limonite_brown.init()

    return {
        description = "Ordinary clay with brown limonite as ore",
        depends = {"clay_ordinary", "mineral_limonite_brown"},
    }

end

function unilib.pkg.clay_ordinary_with_limonite_brown.exec()

    unilib.register_node("unilib:clay_ordinary_with_limonite_brown", nil, mode, {
        -- Texture from PFAA, weakOreClay_brownLimonite.png. Original code
        description = unilib.brackets(S("Brown Limonite Ore"), S("Ordinary Clay")),
        tiles = {"unilib_clay_ordinary.png^unilib_mineral_limonite_brown.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_limonite_brown_lump",
    })

end
