---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_quartz_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_quartz_brown.init()

    return {
        description = "Ordinary stone with brown quartz as ore",
        depends = {"mineral_quartz_brown", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_quartz_brown.exec()

    unilib.register_node("unilib:stone_ordinary_with_quartz_brown", nil, mode, {
        -- Texture from PFAA, strongOreRock_quartz.png. Original code
        description = unilib.brackets(S("Brown Quartz Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_quartz_brown.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_quartz_brown_lump",
    })

end
