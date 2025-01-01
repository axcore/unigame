---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_unobtainium.init()

    return {
        description = "Ordinary stone with unobtainium as ore",
        depends = {"metal_unobtainium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_unobtainium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_unobtainium
        "unilib:stone_ordinary_with_unobtainium",
        "xtraores:stone_with_unobtainium",
        mode,
        {
            description = unilib.utils.brackets(S("Unobtainium Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_unobtainium.png"},
            -- N.B. ore = 1 not in original code
            groups = {extrahard = 0, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_unobtainium_lump",
        }
    )

end
