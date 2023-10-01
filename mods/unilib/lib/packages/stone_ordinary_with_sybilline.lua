---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_sybilline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_sybilline.init()

    return {
        description = "Ordinary stone with sybilline as ore",
        depends = {"metal_sybilline", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_sybilline.exec()

    unilib.register_node(
        -- From xtraores:stone_with_cobalt
        "unilib:stone_ordinary_with_sybilline",
        "xtraores:stone_with_cobalt",
        mode,
        {
            description = unilib.brackets(S("Sybilline Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_sybilline.png"},
            groups = {cracky = 1},
            sounds = unilib.sound_table.stone,

            drop = "unilib:metal_sybilline_lump",
        }
    )

end
