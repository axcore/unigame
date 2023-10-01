---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_mineral_granitic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_mineral_granitic.init()

    return {
        description = "Granitic mineral sand",
        depends = {"mineral_magnetite", "sand_ordinary", "stone_granite_salmon"},
    }

end

function unilib.pkg.sand_mineral_granitic.exec()

    unilib.register_node("unilib:sand_mineral_granitic", nil, mode, {
        -- Texture from PFAA, weakOreSand_graniticMineralSand.png. Original code
        description = S("Granitic Mineral Sand"),
        tiles = {"unilib_sand_mineral_granitic.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_magnetite_lump"}, rarity = 5},
                {items = {"unilib:stone_granite_salmon_cobble"}, rarity = 5},
                {items = {"unilib:sand_ordinary"}},
            },
        },
    })

end
