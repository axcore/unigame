---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_palatinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_palatinium.init()

    return {
        description = "Ordinary stone with palatinium as ore",
        depends = {"metal_palatinium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_palatinium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_platinum
        "unilib:stone_ordinary_with_palatinium",
        "xtraores:stone_with_platinum",
        mode,
        {
            description = unilib.brackets(S("Palatinium Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_palatinium.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,

            drop = "unilib:metal_palatinium_lump",
        }
    )

end
