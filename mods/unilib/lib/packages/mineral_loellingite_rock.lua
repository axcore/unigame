---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_loellingite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_loellingite_rock.init()

    return {
        description = "Loellingite rock (as mineral)",
        notes = "An alternative to the stone ores with loellingite",
        depends = "mineral_loellingite",
    }

end

function unilib.pkg.mineral_loellingite_rock.exec()

    local c_lump = "unilib:mineral_loellingite_lump"
    local hardness = unilib.global.mineral_table["loellingite"]["hardness"]

    unilib.register_mineral_rock("loellingite")

    unilib.register_node("unilib:mineral_loellingite_rock", nil, mode, {
        -- Texture from AATO, lollingite.png. Original code
        description = S("Loellingite Rock"),
        tiles = {"unilib_mineral_loellingite_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_loellingite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
