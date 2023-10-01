---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_petalite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_petalite_rock.init()

    return {
        description = "Petalite rock (as mineral)",
        notes = "An alternative to the stone ores with petalite",
        depends = "mineral_petalite",
    }

end

function unilib.pkg.mineral_petalite_rock.exec()

    local c_lump = "unilib:mineral_petalite_lump"
    local hardness = unilib.mineral_table["petalite"]["hardness"]

    unilib.register_mineral_rock("petalite")

    unilib.register_node("unilib:mineral_petalite_rock", nil, mode, {
        -- Texture from AATO, petalite.png. Original code
        description = S("Petalite Rock"),
        tiles = {"unilib_mineral_petalite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_petalite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
