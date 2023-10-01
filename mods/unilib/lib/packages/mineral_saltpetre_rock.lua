---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_saltpetre_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_saltpetre_rock.init()

    return {
        description = "Saltpetre rock (as mineral)",
        notes = "An alternative to the stone ores with saltpetre",
        depends = "mineral_saltpetre",
    }

end

function unilib.pkg.mineral_saltpetre_rock.exec()

    local c_lump = "unilib:mineral_saltpetre_lump"
    local hardness = unilib.mineral_table["saltpetre"]["hardness"]

    unilib.register_mineral_rock("saltpetre")

    unilib.register_node("unilib:mineral_saltpetre_rock", nil, mode, {
        -- Original to unilib
        description = S("Saltpetre Rock"),
        tiles = {"unilib_mineral_saltpetre_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_saltpetre_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
