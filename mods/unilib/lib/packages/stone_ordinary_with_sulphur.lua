---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_sulphur = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_sulphur.init()

    return {
        description = "Ordinary stone with sulphur as ore",
        depends = {"liquid_lava_ordinary", "mineral_sulphur", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_sulphur.exec()

    unilib.register_node("unilib:stone_ordinary_with_sulphur", "technic:mineral_sulfur", mode, {
        -- From technic:mineral_sulphur
        description = unilib.brackets(S("Sulphur Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_sulphur.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_sulphur_lump",
    })

end
