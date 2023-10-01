---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carrollite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carrollite_rock.init()

    return {
        description = "Carrollite rock (as mineral)",
        notes = "An alternative to the stone ores with carrollite",
        depends = "mineral_carrollite",
    }

end

function unilib.pkg.mineral_carrollite_rock.exec()

    local c_lump = "unilib:mineral_carrollite_lump"
    local hardness = unilib.mineral_table["carrollite"]["hardness"]

    unilib.register_mineral_rock("carrollite")

    unilib.register_node("unilib:mineral_carrollite_rock", nil, mode, {
        -- Texture from AATO, carrollite.png. Original code
        description = S("Carrollite Rock"),
        tiles = {"unilib_mineral_carrollite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_carrollite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
