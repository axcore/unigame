---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_germanite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_germanite_rock.init()

    return {
        description = "Germanite rock (as mineral)",
        notes = "An alternative to the stone ores with germanite",
        depends = "mineral_germanite",
    }

end

function unilib.pkg.mineral_germanite_rock.exec()

    local c_lump = "unilib:mineral_germanite_lump"
    local hardness = unilib.global.mineral_table["germanite"]["hardness"]

    unilib.register_mineral_rock("germanite")

    unilib.register_node("unilib:mineral_germanite_rock", nil, mode, {
        -- Texture from AATO, germanite.png. Original code
        description = S("Germanite Rock"),
        tiles = {"unilib_mineral_germanite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_germanite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
