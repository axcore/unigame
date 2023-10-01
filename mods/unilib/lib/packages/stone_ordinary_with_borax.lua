---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_borax = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_borax.init()

    return {
        description = "Ordinary stone with borax as ore",
        depends = {"mineral_borax", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_borax.exec()

    unilib.register_node("unilib:stone_ordinary_with_borax", nil, mode, {
        -- Original to unilib, since real_minerals doesn't register an ore for borax
        description = unilib.brackets(S("Borax Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_borax.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_borax_lump 3"}, rarity = 15},
                {items = {"unilib:mineral_borax_lump 2"}}
            }
        },
        paramtype = "light",
    })

end
