---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_coke_natural = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_coke_natural.init()

    return {
        description = "Ordinary stone with natural coke as ore",
        depends = {"mineral_coke_natural", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_coke_natural.exec()

    unilib.register_node("unilib:stone_ordinary_with_coke_natural", nil, mode, {
        -- Texture from PFAA, strongCrudeRock_coke.png. Original code
        description = unilib.brackets(S("Natural Coke Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_coke_natural.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_coke_natural_lump",
    })

end
