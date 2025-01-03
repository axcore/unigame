---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_ozymandium.init()

    return {
        description = "Ordinary stone with ozymandium as ore",
        depends = {"metal_ozymandium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_ozymandium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_osmium
        "unilib:stone_ordinary_with_ozymandium",
        "xtraores:stone_with_osmium",
        mode,
        {
            description = unilib.utils.brackets(S("Ozymandium Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_ozymandium.png"},
            -- N.B. ore = 1 not in original code
            groups = {extrahard = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_ozymandium_lump",
        }
    )

end
