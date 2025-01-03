---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_rarium.init()

    return {
        description = "Ordinary stone with rarium as ore",
        depends = {"metal_rarium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_rarium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_rarium
        "unilib:stone_ordinary_with_rarium",
        "xtraores:stone_with_rarium",
        mode,
        {
            description = unilib.utils.brackets(S("Rarium Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_rarium.png"},
            -- N.B. ore = 1 not in original code
            groups = {extrahard = 1, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_rarium_lump",
        }
    )

end
