---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_flux = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_flux.init()

    return {
        description = "Ordinary stone with flux as ore",
        depends = {"mineral_flux", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_flux.exec()

    unilib.register_node("unilib:stone_ordinary_with_flux", nil, mode, {
        -- Original to unilib, since real_minerals doesn't register an ore for flux
        description = unilib.utils.brackets(S("Flux Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_flux.png"},
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_flux_lump 3"}, rarity = 15},
                {items = {"unilib:mineral_flux_lump 2"}},
            },
        },
        paramtype = "light",
    })

end
