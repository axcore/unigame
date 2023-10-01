---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_savanna_with_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_savanna_with_iron.init()

    return {
        description = "Savanna stone with iron as ore",
        depends = {"metal_iron", "stone_savanna"},
    }

end

function unilib.pkg.stone_savanna_with_iron.exec()

    unilib.register_node("unilib:stone_savanna_with_iron", "mapgen:savanna_iron", mode, {
        -- From farlands, mapgen:savanna_iron
        description = unilib.brackets(S("Iron Ore"), S("Savanna Stone")),
        tiles = {"unilib_stone_savanna_with_iron.png"},
        groups = {cracky = 2, ore = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_iron_lump",
    })

end
