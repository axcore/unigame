---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_trona_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_trona_rock.init()

    return {
        description = "Trona rock (as mineral)",
        notes = "An alternative to the stone ores with trona",
        depends = "mineral_trona",
    }

end

function unilib.pkg.mineral_trona_rock.exec()

    local c_lump = "unilib:mineral_trona_lump"
    local hardness = unilib.global.mineral_table["trona"]["hardness"]

    unilib.register_mineral_rock("trona")

    unilib.register_node("unilib:mineral_trona_rock", nil, mode, {
        -- Texture from PFAA, weakOreRock_trona.png. Original code
        description = S("Trona Rock"),
        tiles = {"unilib_mineral_trona_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_trona_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
