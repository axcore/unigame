---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_clausthalite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_clausthalite_rock.init()

    return {
        description = "Clausthalite rock (as mineral)",
        notes = "An alternative to the stone ores with clausthalite",
        depends = "mineral_clausthalite",
    }

end

function unilib.pkg.mineral_clausthalite_rock.exec()

    local c_lump = "unilib:mineral_clausthalite_lump"
    local hardness = unilib.mineral_table["clausthalite"]["hardness"]

    unilib.register_mineral_rock("clausthalite")

    unilib.register_node("unilib:mineral_clausthalite_rock", nil, mode, {
        -- Texture from AATO, clausthalite.png. Original code
        description = S("Clausthalite Rock"),
        tiles = {"unilib_mineral_clausthalite_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_clausthalite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
