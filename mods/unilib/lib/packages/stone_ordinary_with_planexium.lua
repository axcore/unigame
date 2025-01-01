---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_planexium.init()

    return {
        description = "Ordinary stone with planexium as ore",
        depends = {"metal_planexium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_planexium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_platinum
        "unilib:stone_ordinary_with_planexium",
        "xtraores:stone_with_platinum",
        mode,
        {
            description = unilib.utils.brackets(S("Planexium Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_planexium.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 2, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_planexium_lump",
        }
    )

end
