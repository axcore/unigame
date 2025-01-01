---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kesterite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kesterite_rock.init()

    return {
        description = "Kesterite rock (as mineral)",
        notes = "An alternative to the stone ores with kesterite",
        depends = "mineral_kesterite",
    }

end

function unilib.pkg.mineral_kesterite_rock.exec()

    local c_lump = "unilib:mineral_kesterite_lump"
    local hardness = unilib.global.mineral_table["kesterite"]["hardness"]

    unilib.register_mineral_rock("kesterite")

    unilib.register_node("unilib:mineral_kesterite_rock", nil, mode, {
        -- Texture from AATO, kesterite.png. Original code
        description = S("Kesterite Rock"),
        tiles = {"unilib_mineral_kesterite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_kesterite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
