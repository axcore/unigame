---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_ruby = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_ruby.init()

    return {
        description = "Ordinary stone with ruby as ore",
        depends = {"mineral_ruby", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_ruby.exec()

    unilib.register_node("unilib:stone_ordinary_with_ruby", "underch:ruby_ore", mode, {
        -- From underch:ruby_ore
        description = unilib.brackets(S("Ruby Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_ruby.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_ruby_gem",
    })

end
