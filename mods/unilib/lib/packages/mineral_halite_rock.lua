---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_halite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_halite_rock.init()

    return {
        description = "Halite rock (as mineral)",
        notes = "An alternative to the stone ores with halite",
        depends = "mineral_halite",
    }

end

function unilib.pkg.mineral_halite_rock.exec()

    local c_lump = "unilib:mineral_halite_lump"
    local hardness = unilib.global.mineral_table["halite"]["hardness"]

    unilib.register_mineral_rock("halite")

    unilib.register_node("unilib:mineral_halite_rock", nil, mode, {
        -- Texture from PFAA, weakOreRock_salt.png. Original code
        description = S("Halite Rock"),
        tiles = {"unilib_mineral_halite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_halite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
