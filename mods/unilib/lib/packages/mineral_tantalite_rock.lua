---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tantalite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tantalite_rock.init()

    return {
        description = "Tantalite rock (as mineral)",
        notes = "An alternative to the stone ores with tantalite",
        depends = "mineral_tantalite",
    }

end

function unilib.pkg.mineral_tantalite_rock.exec()

    local c_lump = "unilib:mineral_tantalite_lump"
    local hardness = unilib.global.mineral_table["tantalite"]["hardness"]

    unilib.register_mineral_rock("tantalite")

    unilib.register_node("unilib:mineral_tantalite_rock", nil, mode, {
        -- Texture from AATO, tantalite.png. Original code
        description = S("Tantalite Rock"),
        tiles = {"unilib_mineral_tantalite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_tantalite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
