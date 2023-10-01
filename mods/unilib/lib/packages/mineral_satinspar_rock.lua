---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_satinspar_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_satinspar_rock.init()

    return {
        description = "Satin spar rock (as mineral)",
        notes = "An alternative to the stone ores with satinspar",
        depends = "mineral_satinspar",
    }

end

function unilib.pkg.mineral_satinspar_rock.exec()

    local c_lump = "unilib:mineral_satinspar_lump"
    local hardness = unilib.mineral_table["satinspar"]["hardness"]

    unilib.register_mineral_rock("satinspar")

    unilib.register_node("unilib:mineral_satinspar_rock", nil, mode, {
        -- Original to unilib
        description = S("Satin Spar Rock"),
        tiles = {"unilib_mineral_satinspar_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_satinspar_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
