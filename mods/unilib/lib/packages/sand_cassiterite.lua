---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_cassiterite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_cassiterite.init()

    return {
        description = "Cassiterite sand",
        depends = {"mineral_cassiterite", "sand_ordinary"},
    }

end

function unilib.pkg.sand_cassiterite.exec()

    unilib.register_node("unilib:sand_cassiterite", nil, mode, {
        -- Texture from PFAA, weakOreSand_cassiteriteSand.png. Original code
        description = S("Cassiterite Sand"),
        tiles = {"unilib_sand_cassiterite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_cassiterite_lump"}, rarity = 3},
                {items = {"unilib:sand_ordinary"}},
            },
        },
    })

end
