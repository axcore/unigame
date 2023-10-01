---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_magnetite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_magnetite_rock.init()

    return {
        description = "Magnetite rock (as mineral)",
        notes = "An alternative to the stone ores with magnetite",
        depends = "mineral_magnetite",
    }

end

function unilib.pkg.mineral_magnetite_rock.exec()

    local c_lump = "unilib:mineral_magnetite_lump"
    local hardness = unilib.mineral_table["magnetite"]["hardness"]

    unilib.register_mineral_rock("magnetite")

    unilib.register_node("unilib:mineral_magnetite_rock", nil, mode, {
        -- Texture from AATO, magnetite.png. Original code
        description = S("Magnetite Rock"),
        tiles = {"unilib_mineral_magnetite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_magnetite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
