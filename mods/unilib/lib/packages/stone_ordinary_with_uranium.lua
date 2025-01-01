---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_uranium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_uranium.init()

    return {
        description = "Ordinary stone with uranium as ore",
        depends = {"metal_uranium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_uranium.exec()

    unilib.register_node("unilib:stone_ordinary_with_uranium", "technic:mineral_uranium", mode, {
        -- From technic:mineral_uranium
        description = unilib.utils.brackets(S("Uranium Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_metal_uranium.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 3, ore = 1, radioactive = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:metal_uranium_lump",
    })

end
