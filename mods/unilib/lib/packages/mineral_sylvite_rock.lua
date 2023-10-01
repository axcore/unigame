---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sylvite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sylvite_rock.init()

    return {
        description = "Sylvite rock (as mineral)",
        notes = "An alternative to the stone ores with sylvite",
        depends = "mineral_sylvite",
    }

end

function unilib.pkg.mineral_sylvite_rock.exec()

    local c_lump = "unilib:mineral_sylvite_lump"
    local hardness = unilib.mineral_table["sylvite"]["hardness"]

    unilib.register_mineral_rock("sylvite")

    unilib.register_node("unilib:mineral_sylvite_rock", nil, mode, {
        -- Texture from AATO, sylvite.png. Original code
        description = S("Sylvite Rock"),
        tiles = {"unilib_mineral_sylvite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_sylvite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
