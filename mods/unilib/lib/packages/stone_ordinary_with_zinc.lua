---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_zinc = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_zinc.init()

    return {
        description = "Ordinary stone with zinc as ore",
        depends = {"metal_zinc", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_zinc.exec()

    unilib.register_node("unilib:stone_ordinary_with_zinc", "technic:mineral_zinc", mode, {
        -- From technic:mineral_zinc
        description = unilib.utils.brackets(S("Zinc Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_metal_zinc.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:metal_zinc_lump",
    })

end

