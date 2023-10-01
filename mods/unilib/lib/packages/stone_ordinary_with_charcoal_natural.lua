---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_charcoal_natural = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_charcoal_natural.init()

    return {
        description = "Ordinary stone with natural charcoal as ore",
        depends = {"mineral_charcoal_natural", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_charcoal_natural.exec()

    unilib.register_node("unilib:stone_ordinary_with_charcoal_natural", nil, mode, {
        -- Original to unilib, since real_minerals doesn't register an ore for natural charcoal
        description = unilib.brackets(S("Natural Charcoal Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_charcoal_natural.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_charcoal_natural_lump 3"}, rarity = 15},
                {items = {"unilib:mineral_charcoal_natural_lump 2"}}
            }
        },
        paramtype = "light",
    })

end
