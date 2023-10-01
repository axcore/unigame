---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_argutite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_argutite_rock.init()

    return {
        description = "Argutite rock (as mineral)",
        notes = "An alternative to the stone ores with argutite",
        depends = "mineral_argutite",
    }

end

function unilib.pkg.mineral_argutite_rock.exec()

    local c_lump = "unilib:mineral_argutite_lump"
    local hardness = unilib.mineral_table["argutite"]["hardness"]

    unilib.register_mineral_rock("argutite")

    unilib.register_node("unilib:mineral_argutite_rock", nil, mode, {
        -- Texture from AATO, argutite.png. Original code
        description = S("Argutite Rock"),
        tiles = {"unilib_mineral_argutite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_argutite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
