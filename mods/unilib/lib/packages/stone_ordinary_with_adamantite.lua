---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_adamantite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_adamantite.init()

    return {
        description = "Ordinary stone with adamantite as ore",
        depends = {"metal_adamantite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_adamantite.exec()

    unilib.register_node(
        -- From xtraores:stone_with_adamantite
        "unilib:stone_ordinary_with_adamantite",
        "xtraores:stone_with_adamantite",
        mode,
        {
            description = unilib.utils.brackets(S("Adamantite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_metal_adamantite.png"},
            -- N.B. ore = 1 not in original code
            groups = {extrahard = 2, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_adamantite_lump",
        }
    )

end
