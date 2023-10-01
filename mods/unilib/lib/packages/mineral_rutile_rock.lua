---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_rutile_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_rutile_rock.init()

    return {
        description = "Rutile rock (as mineral)",
        notes = "An alternative to the stone ores with rutile",
        depends = "mineral_rutile",
    }

end

function unilib.pkg.mineral_rutile_rock.exec()

    local c_lump = "unilib:mineral_rutile_lump"
    local hardness = unilib.mineral_table["rutile"]["hardness"]

    unilib.register_mineral_rock("rutile")

    unilib.register_node("unilib:mineral_rutile_rock", nil, mode, {
        -- Texture from AATO, rutile.png. Original code
        description = S("Rutile Rock"),
        tiles = {"unilib_mineral_rutile_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_rutile_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
