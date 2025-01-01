---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_wollastonite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_wollastonite_rock.init()

    return {
        description = "Wollastonite rock (as mineral)",
        notes = "An alternative to the stone ores with wollastonite",
        depends = "mineral_wollastonite",
    }

end

function unilib.pkg.mineral_wollastonite_rock.exec()

    local c_lump = "unilib:mineral_wollastonite_lump"
    local hardness = unilib.global.mineral_table["wollastonite"]["hardness"]

    unilib.register_mineral_rock("wollastonite")

    unilib.register_node("unilib:mineral_wollastonite_rock", nil, mode, {
        -- Texture from PFAA, mediumOreRock_wollastonite.png. Original code
        description = S("Wollastonite Rock"),
        tiles = {"unilib_mineral_wollastonite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_wollastonite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
