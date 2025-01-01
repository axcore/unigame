---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hydrozincite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hydrozincite_rock.init()

    return {
        description = "Hydrozincite rock (as mineral)",
        notes = "An alternative to the stone ores with hydrozincite",
        depends = "mineral_hydrozincite",
    }

end

function unilib.pkg.mineral_hydrozincite_rock.exec()

    local c_lump = "unilib:mineral_hydrozincite_lump"
    local hardness = unilib.global.mineral_table["hydrozincite"]["hardness"]

    unilib.register_mineral_rock("hydrozincite")

    unilib.register_node("unilib:mineral_hydrozincite_rock", nil, mode, {
        -- Texture from AATO, hydrozincite.png. Original code
        description = S("Hydrozincite Rock"),
        tiles = {"unilib_mineral_hydrozincite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_hydrozincite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
