---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_savanna_with_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_savanna_with_coal.init()

    return {
        description = "Savanna stone with coal as ore",
        depends = {"mineral_coal", "stone_savanna"},
    }

end

function unilib.pkg.stone_savanna_with_coal.exec()

    unilib.register_node("unilib:stone_savanna_with_coal", "mapgen:savanna_coal", mode, {
        -- From farlands, mapgen:savanna_coal
        description = unilib.brackets(S("Coal Ore"), S("Savanna Stone")),
        tiles = {"unilib_stone_savanna_with_coal.png"},
        groups = {cracky = 3, ore = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_coal_lump",
    })

end
