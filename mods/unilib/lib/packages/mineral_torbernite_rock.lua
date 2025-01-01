---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_torbernite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_torbernite_rock.init()

    return {
        description = "Torbernite rock (as mineral)",
        notes = "An alternative to the stone ores with torbernite",
        depends = "mineral_torbernite",
    }

end

function unilib.pkg.mineral_torbernite_rock.exec()

    local c_lump = "unilib:mineral_torbernite_lump"
    local hardness = unilib.global.mineral_table["torbernite"]["hardness"]

    unilib.register_mineral_rock("torbernite")

    unilib.register_node("unilib:mineral_torbernite_rock", nil, mode, {
        -- Texture from AATO, torbenite.png. Original code
        description = S("Torbernite Rock"),
        tiles = {"unilib_mineral_torbernite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_torbernite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
