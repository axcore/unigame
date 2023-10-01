---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_tritonium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_tritonium.init()

    return {
        description = "Ordinary stone with tritonium as ore",
        depends = {"metal_tritonium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_tritonium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_titanium
        "unilib:stone_ordinary_with_tritonium",
        "xtraores:stone_with_titanium",
        mode,
        {
            description = unilib.brackets(S("Tritonium Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_tritonium.png"},
            groups = {extrahard = 0},
            sounds = unilib.sound_table.stone,

            drop = "unilib:metal_tritonium_lump",
        }
    )

end
