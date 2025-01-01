---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_borax_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_borax_rock.init()

    return {
        description = "Borax rock (as mineral)",
        notes = "An alternative to the stone ores with borax",
        depends = "mineral_borax",
    }

end

function unilib.pkg.mineral_borax_rock.exec()

    local c_lump = "unilib:mineral_borax_lump"
    local hardness = unilib.global.mineral_table["borax"]["hardness"]

    unilib.register_mineral_rock("borax")

    unilib.register_node("unilib:mineral_borax_rock", nil, mode, {
        -- Texture from PFAA, weakOreRock_borax.png. Original code
        description = S("Borax Rock"),
        tiles = {"unilib_mineral_borax_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_borax_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
