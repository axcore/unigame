---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_thortveitite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_thortveitite_rock.init()

    return {
        description = "Thortveitite rock (as mineral)",
        notes = "An alternative to the stone ores with thortveitite",
        depends = "mineral_thortveitite",
    }

end

function unilib.pkg.mineral_thortveitite_rock.exec()

    local c_lump = "unilib:mineral_thortveitite_lump"
    local hardness = unilib.global.mineral_table["thortveitite"]["hardness"]

    unilib.register_mineral_rock("thortveitite")

    unilib.register_node("unilib:mineral_thortveitite_rock", nil, mode, {
        -- Texture from AATO, thortveitite.png. Original code
        description = S("Thortveitite Rock"),
        tiles = {"unilib_mineral_thortveitite_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_thortveitite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
