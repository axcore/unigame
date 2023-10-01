---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lepidolite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lepidolite.init()

    return {
        description = "Ordinary stone with lepidolite as ore",
        depends = {"mineral_lepidolite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_lepidolite.exec()

    unilib.register_node("unilib:stone_ordinary_with_lepidolite", nil, mode, {
        -- Texture from PFAA, mediumOreRock_lepidolite.png. Original code
        description = unilib.brackets(S("Lepidolite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_lepidolite.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_lepidolite_lump",
    })

end
