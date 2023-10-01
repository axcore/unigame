---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_magnesite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_magnesite_rock.init()

    return {
        description = "Magnesite rock (as mineral)",
        notes = "An alternative to the stone ores with magnesite",
        depends = "mineral_magnesite",
    }

end

function unilib.pkg.mineral_magnesite_rock.exec()

    local c_lump = "unilib:mineral_magnesite_lump"
    local hardness = unilib.mineral_table["magnesite"]["hardness"]

    unilib.register_mineral_rock("magnesite")

    unilib.register_node("unilib:mineral_magnesite_rock", nil, mode, {
        -- Texture from AATO, magnesite.png. Original code
        description = S("Magnesite Rock"),
        tiles = {"unilib_mineral_magnesite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_magnesite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
