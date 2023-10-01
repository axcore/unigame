---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carnotite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carnotite_rock.init()

    return {
        description = "Carnotite rock (as mineral)",
        notes = "An alternative to the stone ores with carnotite",
        depends = "mineral_carnotite",
    }

end

function unilib.pkg.mineral_carnotite_rock.exec()

    local c_lump = "unilib:mineral_carnotite_lump"
    local hardness = unilib.mineral_table["carnotite"]["hardness"]

    unilib.register_mineral_rock("carnotite")

    unilib.register_node("unilib:mineral_carnotite_rock", nil, mode, {
        -- Texture from AATO, carnotite.png. Original code
        description = S("Carnotite Rock"),
        tiles = {"unilib_mineral_carnotite_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_carnotite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
