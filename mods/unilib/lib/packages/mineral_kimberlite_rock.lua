---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kimberlite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kimberlite_rock.init()

    return {
        description = "Kimberlite rock (as mineral)",
        notes = "An alternative to the stone ores with kimberlite",
        depends = "mineral_kimberlite",
    }

end

function unilib.pkg.mineral_kimberlite_rock.exec()

    local c_lump = "unilib:mineral_kimberlite_lump"
    local hardness = unilib.mineral_table["kimberlite"]["hardness"]

    unilib.register_mineral_rock("kimberlite")

    unilib.register_node("unilib:mineral_kimberlite_rock", nil, mode, {
        -- Texture from AATO, kimberlite.png. Original code
        description = S("Kimberlite Rock"),
        tiles = {"unilib_mineral_kimberlite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_kimberlite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
