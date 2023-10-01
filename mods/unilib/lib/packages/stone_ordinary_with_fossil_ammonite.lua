---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_fossil_ammonite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_fossil_ammonite.init()

    return {
        description = "Ordinary stone with ammonite fossil",
    }

end

function unilib.pkg.stone_ordinary_with_fossil_ammonite.exec()

    unilib.register_node(
        -- From farlands, mapgen:stone_with_ammonite
        "unilib:stone_ordinary_with_fossil_ammonite",
        "mapgen:stone_with_ammonite",
        mode,
        {
            description = S("Ordinary Stone with Ammonite Fossil"),
            tiles = {"unilib_stone_ordinary_with_fossil_ammonite.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,
        }
    )

end
