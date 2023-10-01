---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chromite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chromite_rock.init()

    return {
        description = "Chromite rock (as mineral)",
        notes = "An alternative to the stone ores with chromite",
        depends = "mineral_chromite",
    }

end

function unilib.pkg.mineral_chromite_rock.exec()

    local c_lump = "unilib:mineral_chromite_lump"
    local hardness = unilib.mineral_table["chromite"]["hardness"]

    unilib.register_mineral_rock("chromite")

    unilib.register_node("unilib:mineral_chromite_rock", nil, mode, {
        -- Texture from AATO, chromite.png. Original code
        description = S("Chromite Rock"),
        tiles = {"unilib_mineral_chromite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_chromite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
