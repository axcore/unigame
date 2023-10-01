---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_magnetite_vanadium_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_magnetite_vanadium_rock.init()

    return {
        description = "Vanadium magnetite rock (as mineral)",
        notes = "An alternative to the stone ores with vanadium magnetite",
        depends = "mineral_magnetite_vanadium",
    }

end

function unilib.pkg.mineral_magnetite_vanadium_rock.exec()

    local c_lump = "unilib:mineral_magnetite_vanadium_lump"
    local hardness = unilib.mineral_table["magnetite_vanadium"]["hardness"]

    unilib.register_mineral_rock("magnetite_vanadium")

    unilib.register_node("unilib:mineral_magnetite_vanadium_rock", nil, mode, {
        -- Original to unilib
        description = S("Vanadium Magnetite Rock"),
        tiles = {"unilib_mineral_magnetite_vanadium_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_magnetite_vanadium_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
