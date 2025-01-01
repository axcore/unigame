---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_mirabilite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_mirabilite_rock.init()

    return {
        description = "Mirabilite rock (as mineral)",
        notes = "An alternative to the stone ores with mirabilite",
        depends = "mineral_mirabilite",
    }

end

function unilib.pkg.mineral_mirabilite_rock.exec()

    local c_lump = "unilib:mineral_mirabilite_lump"
    local hardness = unilib.global.mineral_table["mirabilite"]["hardness"]

    unilib.register_mineral_rock("mirabilite")

    unilib.register_node("unilib:mineral_mirabilite_rock", nil, mode, {
        -- Texture from PFAA, weakOreRock_mirabilite.png. Original code
        description = S("Mirabilite Rock"),
        tiles = {"unilib_mineral_mirabilite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_mirabilite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
