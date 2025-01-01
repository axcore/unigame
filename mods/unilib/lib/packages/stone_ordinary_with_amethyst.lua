---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_amethyst = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_amethyst.init()

    return {
        description = "Ordinary stone with amethyst as ore",
        depends = {"mineral_amethyst", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_amethyst.exec()

    unilib.register_node("unilib:stone_ordinary_with_amethyst", "underch:amethyst_ore", mode, {
        -- From underch:amethyst_ore
        description = unilib.utils.brackets(S("Amethyst Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_amethyst.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_amethyst_crystal",
    })

end
