---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_calcite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_calcite_rock.init()

    return {
        description = "Calcite rock (as mineral)",
        notes = "An alternative to the stone ores with calcite",
        depends = "mineral_calcite",
    }

end

function unilib.pkg.mineral_calcite_rock.exec()

    local c_lump = "unilib:mineral_calcite_lump"
    local hardness = unilib.global.mineral_table["calcite"]["hardness"]

    unilib.register_mineral_rock("calcite")

    unilib.register_node("unilib:mineral_calcite_rock", nil, mode, {
        -- Texture from AATO, calcite.png. Original code
        description = S("Calcite Rock"),
        tiles = {"unilib_mineral_calcite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_calcite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
