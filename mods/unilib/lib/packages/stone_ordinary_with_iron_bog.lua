---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_iron_bog = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_iron_bog.init()

    return {
        description = "Ordinary stone with bog iron as ore",
        depends = {"metal_iron", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_iron_bog.exec()

    unilib.register_node("unilib:stone_ordinary_with_iron_bog", nil, mode, {
        -- Texture from PFAA, weakOreGround_bogIron.png. Original code
        description = unilib.brackets(S("Bog Iron Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_iron_bog.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:metal_iron_lump",
    })

end
