---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_rhodonite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_rhodonite_rock.init()

    return {
        description = "Rhodonite rock (as mineral)",
        notes = "An alternative to the stone ores with rhodonite",
        depends = "mineral_rhodonite",
    }

end

function unilib.pkg.mineral_rhodonite_rock.exec()

    local c_lump = "unilib:mineral_rhodonite_lump"
    local hardness = unilib.mineral_table["rhodonite"]["hardness"]

    unilib.register_mineral_rock("rhodonite")

    unilib.register_node("unilib:mineral_rhodonite_rock", nil, mode, {
        -- Texture from AATO, rhodonite.png. Original code
        description = S("Rhodonite Rock"),
        tiles = {"unilib_mineral_rhodonite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_rhodonite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
