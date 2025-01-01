---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pumice_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pumice_rock.init()

    return {
        description = "Pumice rock (as mineral)",
        notes = "An alternative to the stone ores with pumice",
        depends = "mineral_pumice",
    }

end

function unilib.pkg.mineral_pumice_rock.exec()

    local c_lump = "unilib:mineral_pumice_lump"
    local hardness = unilib.global.mineral_table["pumice"]["hardness"]

    unilib.register_mineral_rock("pumice")

    unilib.register_node("unilib:mineral_pumice_rock", nil, mode, {
        -- Texture from PFAA, strongOreRock_pumice.png. Original code
        description = S("Pumice Rock"),
        tiles = {"unilib_mineral_pumice_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_pumice_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
