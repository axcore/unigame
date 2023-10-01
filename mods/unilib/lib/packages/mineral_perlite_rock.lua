---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_perlite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_perlite_rock.init()

    return {
        description = "Perlite rock (as mineral)",
        notes = "An alternative to the stone ores with perlite",
        depends = "mineral_perlite",
    }

end

function unilib.pkg.mineral_perlite_rock.exec()

    local c_lump = "unilib:mineral_perlite_lump"
    local hardness = unilib.mineral_table["perlite"]["hardness"]

    unilib.register_mineral_rock("perlite")

    unilib.register_node("unilib:mineral_perlite_rock", nil, mode, {
        -- Texture from PFAA, strongOreRock_perlite.png. Original code
        description = S("Perlite Rock"),
        tiles = {"unilib_mineral_perlite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_perlite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
