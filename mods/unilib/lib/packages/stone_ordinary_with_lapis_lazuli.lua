---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lapis_lazuli = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lapis_lazuli.init()

    return {
        description = "Ordinary stone with lapis lazuli as ore",
        depends = {"mineral_lapis_lazuli", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_lapis_lazuli.exec()

    unilib.register_node("unilib:stone_ordinary_with_lapis_lazuli", nil, mode, {
        -- Texture from PFAA, vanillaOreRock_lapis.png. Original code
        description = unilib.brackets(S("Lapis Lazuli Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_lapis_lazuli.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_lapis_lazuli_lump",
    })

end
