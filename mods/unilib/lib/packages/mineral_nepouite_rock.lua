---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_nepouite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_nepouite_rock.init()

    return {
        description = "Nepouite rock (as mineral)",
        notes = "An alternative to the stone ores with nepouite",
        depends = "mineral_nepouite",
    }

end

function unilib.pkg.mineral_nepouite_rock.exec()

    local c_lump = "unilib:mineral_nepouite_lump"
    local hardness = unilib.mineral_table["nepouite"]["hardness"]

    unilib.register_mineral_rock("nepouite")

    unilib.register_node("unilib:mineral_nepouite_rock", nil, mode, {
        -- Texture from AATO, nepouite.png. Original code
        description = S("Nepouite Rock"),
        tiles = {"unilib_mineral_nepouite_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_nepouite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
