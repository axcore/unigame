---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_limonite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_limonite_rock.init()

    return {
        description = "Limonite rock (as mineral)",
        notes = "An alternative to the stone ores with limonite",
        depends = {"mineral_limonite_brown", "mineral_limonite_yellow"},
    }

end

function unilib.pkg.mineral_limonite_rock.exec()

    -- (No call to unilib.register_mineral_rock(), because the lumps come in two variants)

    -- (Assume both limonites have the same hardness)
    local hardness = unilib.global.mineral_table["limonite_brown"]["hardness"]

    unilib.register_node("unilib:mineral_limonite_rock", nil, mode, {
        -- Texture from AATO, limonite.png. Original code
        description = S("Limonite Rock"),
        tiles = {"unilib_mineral_limonite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        -- (AATO provides limonite in two colours; this rock drops both of them)
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_limonite_rock"}, rarity = (100 * hardness)},
                {items = {"unilib:mineral_limonite_brown_lump" .. " 2"}, rarity = (2 + hardness)},
                {items = {"unilib:mineral_limonite_yellow_lump" .. " 2"}, rarity = (2 + hardness)},
                {items = {"unilib:mineral_limonite_brown_lump"}},
                {items = {"unilib:mineral_limonite_yellow_lump"}},
            },
        },
    })

end
