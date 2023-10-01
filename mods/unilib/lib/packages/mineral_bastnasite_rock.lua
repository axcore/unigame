---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bastnasite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bastnasite_rock.init()

    return {
        description = "Bastnasite rock (as mineral)",
        notes = "An alternative to the stone ores with bastnasite",
        depends = "mineral_bastnasite",
    }

end

function unilib.pkg.mineral_bastnasite_rock.exec()

    local c_lump = "unilib:mineral_bastnasite_lump"
    local hardness = unilib.mineral_table["bastnasite"]["hardness"]

    unilib.register_mineral_rock("bastnasite")

    unilib.register_node("unilib:mineral_bastnasite_rock", nil, mode, {
        -- Texture from AATO, bastnasite.png. Original code
        description = S("Bastnasite Rock"),
        tiles = {"unilib_mineral_bastnasite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_bastnasite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
