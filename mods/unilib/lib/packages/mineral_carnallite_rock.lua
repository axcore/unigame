---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carnallite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carnallite_rock.init()

    return {
        description = "Carnallite rock (as mineral)",
        notes = "An alternative to the stone ores with carnallite",
        depends = "mineral_carnallite",
    }

end

function unilib.pkg.mineral_carnallite_rock.exec()

    local c_lump = "unilib:mineral_carnallite_lump"
    local hardness = unilib.global.mineral_table["carnallite"]["hardness"]

    unilib.register_mineral_rock("carnallite")

    unilib.register_node("unilib:mineral_carnallite_rock", nil, mode, {
        -- Texture from AATO, carnallite.png. Original code
        description = S("Carnallite Rock"),
        tiles = {"unilib_mineral_carnallite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_carnallite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
